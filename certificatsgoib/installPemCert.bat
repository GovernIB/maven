
@echo off
setlocal

echo [%date%, %time%] 1>> log.txt


REM Comprovam que tenim l'executable openssl 
where /q openssl
if ERRORLEVEL 1 (
    echo OpenSSL no està instal·lat o no està dins el PATH. Si empres Cygwin assegurat que C:\cygwin64\bin està al PATH
    exit /B
)

REM Comprova que s'ha definit JAVA_HOME i la versió de la màquina virtual
if NOT DEFINED JAVA_HOME (
	echo Ha de definir la variable JAVA_HOME
	exit /B
)

set PATH=%JAVA_HOME%\bin;%PATH%
for /f tokens^=2-5^ delims^=.-_+^" %%j in ('java -fullversion 2^>^&1') do set "jver=%%j%%k%%l"

if %jver% LSS 160 (
	echo Versió de java no soportada
	exit /b
)

REM Java 11 canvia el directori del fitxer
IF %jver% LSS 1100 (
	set TRUSTSTORE="%JAVA_HOME%\jre\lib\security\cacerts"
) else (
	set TRUSTSTORE="%JAVA_HOME%\lib\security\cacerts"
)






	set ALIAS=%1
	set ALIAS=%ALIAS:.=_%
	set PEMFILE=%1

	

	keytool -list -alias %ALIAS% -keystore %TRUSTSTORE% -storepass changeit 1>> log.txt 2>&1
	if NOT ERRORLEVEL 1 (
		echo Alias %ALIAS% ja existeix, l'eliminam
		keytool -delete -alias %ALIAS% -keystore %TRUSTSTORE% -storepass changeit 1>> log.txt 2>&1
	)

	echo Importar certificat %PEMFILE% amb l'alias %ALIAS%
	keytool -importcert -noprompt -file %PEMFILE% -alias %ALIAS% -keystore %TRUSTSTORE% -storepass changeit 1>> log.txt 2>&1
	if ERRORLEVEL 1 (
		echo Error incorporant certificat %PEMFILE% amb alias %ALIAS%
	) else (
		echo Certificat %PEMFILE% amb alias %ALIAS% incorporat
	)



