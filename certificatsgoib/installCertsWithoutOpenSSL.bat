@echo off
set DOMAIN=%1
set CERT_FILE=%DOMAIN%.crt
set KEYSTORE_PATH="%JAVA_HOME%\lib\security\cacerts"
set ALIAS=%DOMAIN%
set PASSWORD=changeit

REM Crear un programa Java temporal para descargar el certificado
set JAVA_PROGRAM=GetCertificate
echo import java.io.*;> %JAVA_PROGRAM%.java
echo import java.net.*;>> %JAVA_PROGRAM%.java
echo import javax.net.ssl.*;>> %JAVA_PROGRAM%.java
echo import java.security.cert.Certificate;>> %JAVA_PROGRAM%.java
echo public class %JAVA_PROGRAM% {>> %JAVA_PROGRAM%.java
echo public static void main(String[] args) throws Exception {>> %JAVA_PROGRAM%.java
echo     String host = args[0];>> %JAVA_PROGRAM%.java
echo     int port = 443;>> %JAVA_PROGRAM%.java
echo     if (host.contains(":")) {>> %JAVA_PROGRAM%.java
echo         String[] parts = host.split(":");>> %JAVA_PROGRAM%.java
echo         host = parts[0];>> %JAVA_PROGRAM%.java
echo         port = Integer.parseInt(parts[1]);>> %JAVA_PROGRAM%.java
echo     }>> %JAVA_PROGRAM%.java
echo     SSLContext context = SSLContext.getInstance("TLS");>> %JAVA_PROGRAM%.java
echo     context.init(null, null, null);>> %JAVA_PROGRAM%.java
echo     SSLSocketFactory factory = context.getSocketFactory();>> %JAVA_PROGRAM%.java
echo     try (SSLSocket socket = (SSLSocket) factory.createSocket(host, port)) {>> %JAVA_PROGRAM%.java
echo         socket.startHandshake();>> %JAVA_PROGRAM%.java
echo         Certificate[] certs = socket.getSession().getPeerCertificates();>> %JAVA_PROGRAM%.java
echo         for (Certificate cert : certs) {>> %JAVA_PROGRAM%.java
echo             try (FileOutputStream fos = new FileOutputStream(host + ".crt")) {>> %JAVA_PROGRAM%.java
echo                 fos.write(cert.getEncoded());>> %JAVA_PROGRAM%.java
echo             }>> %JAVA_PROGRAM%.java
echo             System.out.println("Certificado guardado en: " + host + ".crt");>> %JAVA_PROGRAM%.java
echo             break;>> %JAVA_PROGRAM%.java
echo         }>> %JAVA_PROGRAM%.java
echo     }>> %JAVA_PROGRAM%.java
echo }>> %JAVA_PROGRAM%.java
echo }>> %JAVA_PROGRAM%.java

REM Compilar el programa Java
javac %JAVA_PROGRAM%.java
if %ERRORLEVEL% neq 0 (
    echo Error al compilar el programa Java.
    del %JAVA_PROGRAM%.java
    exit /b 1
)

REM Ejecutar el programa Java para descargar el certificado
java %JAVA_PROGRAM% %DOMAIN%
if %ERRORLEVEL% neq 0 (
    echo Error al descargar el certificado.
    del %JAVA_PROGRAM%.java
    del %JAVA_PROGRAM%.class
    exit /b 1
)

REM Eliminar el alias existente del almacén si ya está presente
keytool -delete -alias %ALIAS% -keystore %KEYSTORE_PATH% -storepass %PASSWORD% >nul 2>&1

REM Importar el certificado al almacén de confianza Java
keytool -import -trustcacerts -keystore %KEYSTORE_PATH% -storepass %PASSWORD% -noprompt -alias %ALIAS% -file %CERT_FILE%
if %ERRORLEVEL% neq 0 (
    echo Error al importar el certificado.
    del %CERT_FILE%
    del %JAVA_PROGRAM%.java
    del %JAVA_PROGRAM%.class
    exit /b 1
)

REM Limpieza
del %CERT_FILE%
del %JAVA_PROGRAM%.java
del %JAVA_PROGRAM%.class
echo Certificado importado con éxito en el almacén de certificados.

exit /b 0
