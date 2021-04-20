# afirmades2_caib_es.pem
# afirmades_caib_es.pem
# dev_caib_es.pem
# intranet_caib_es.pem
# pre_firmacloud_com.pem

export JAVA_HOME=/usr/local/jdk1.6.0_45
#export JAVA_HOME=/usr/local/jdk1.7.0_80


export  TRUSTSTORE=$JAVA_HOME/jre/lib/security/cacerts

# -alias %ALIAS% 
$JAVA_HOME/bin/keytool -importcert -noprompt -alias afirmades_caib_es -file ./afirmades_caib_es.pem -keystore $TRUSTSTORE -storepass changeit

$JAVA_HOME/bin/keytool -importcert -noprompt -alias afirmades2_caib_es -file ./afirmades2_caib_es.pem -keystore $TRUSTSTORE -storepass changeit

$JAVA_HOME/bin/keytool -importcert -noprompt -alias dev_caib_es  -file ./dev_caib_es.pem -keystore $TRUSTSTORE -storepass changeit

$JAVA_HOME/bin/keytool -importcert -noprompt -alias intranet_caib_es  -file ./intranet_caib_es.pem -keystore $TRUSTSTORE -storepass changeit

$JAVA_HOME/bin/keytool -importcert -noprompt -alias pre_firmacloud_com -file ./pre_firmacloud_com.pem -keystore $TRUSTSTORE -storepass changeit





