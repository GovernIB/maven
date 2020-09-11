
# Script per instal·lar certificats emprats dins desenvolupaments del GOIB dins Java

L'script `installCerts.bat` davalla automàticament els certificats d'una sèrie de servidors i els incorpora automàticament al fitxer `cacerts` de la màquina virtual

### Requisits

* Especificar variable d'entorn `JAVA_HOME` (provat amb Java 6, 7, 8 i 11)
* L'executable `openssl` ha d'estar dins el `PATH`. Si s'empra cygwin per exemple basta assegurar-se que `C:\cygwin64\bin` està dins el `PATH`

### Funcionament

Per cada servidor definit internament dins la variable `SERVIDORS`:
* Davalla el seu certificat i el guarda dins un fitxer `PEM` al directori `pemfiles`
* Importa el certificat dins `cacerts` (si l'alias emprat existeix, prèviament l'elimina)

Els noms emprats pel fitxer del certificat i alias es deriven automàticament del nom del servidor, canviant `.` per `_`. Per exemple, en el cas del servidor `dev.caib.es`, davallarà el fitxer dins `pemfiles\dev_caib_es.pem` i l'incorporarà dins `cacerts` amb l'alias `dev_caib_es`

L'script guarda un log dins el fitxer `log.txt`. Cada execució comença amb la data i l'hora.

> Nota: Si la màquina virtual està instal·lada dins el directori de windows `C:\Program Files` es possible que calgui executar l'script com a administrador per tenir permissos per modificar el fitxer `cacerts`

### Exemple

```
C:\Users\areus\FEINA>installCerts.bat
Els certificats es davallaran a dins el directori "pemfiles" i s'afegiran a C:\dev\java\jdk1.6.0_45\jre\lib\security\cacerts
======
Davallant certificat de dev.caib.es:443 i guardant-lo a pemfiles\dev_caib_es.pem
Importar certificat pemfiles\dev_caib_es.pem amb l'alias dev_caib_es
Certificat pemfiles\dev_caib_es.pem amb alias dev_caib_es incorporat
======
Davallant certificat de intranet.caib.es:443 i guardant-lo a pemfiles\intranet_caib_es.pem
Importar certificat pemfiles\intranet_caib_es.pem amb l'alias intranet_caib_es
Certificat pemfiles\intranet_caib_es.pem amb alias intranet_caib_es incorporat
======
Davallant certificat de afirmades.caib.es:4430 i guardant-lo a pemfiles\afirmades_caib_es.pem
Importar certificat pemfiles\afirmades_caib_es.pem amb l'alias afirmades_caib_es
Certificat pemfiles\afirmades_caib_es.pem amb alias afirmades_caib_es incorporat
======
Davallant certificat de pre.firmacloud.com:443 i guardant-lo a pemfiles\pre_firmacloud_com.pem
Alias pre_firmacloud_com ja existeix, l'eliminam
Importar certificat pemfiles\pre_firmacloud_com.pem amb l'alias pre_firmacloud_com
Certificat pemfiles\pre_firmacloud_com.pem amb alias pre_firmacloud_com incorporat
```


