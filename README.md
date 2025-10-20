# CAIB Artifacts


Conjunt de pom amb les dependències i altres elements requerits pels projectes desenvolupats a la CAIB que utilitzin JDK11+JBOSS7.2 o JDK11+JBOSS7.2+DISTRIBUCIÓ_GITHUB_GOVERNIB_MAVEN.

# JDK11+JBOSS7.2/7.4

Per les solucions que utilitzin JDK11 i JBOSS 7.2/7.4 s'ha de fer que el pom arrel tengui el següent parent:

    <parent>
        <artifactId>caib-artifacts-jdk11-jboss72or7.4</artifactId>
        <groupId>es.caib.maven</groupId>
        <version>1.0.1-SNAPSHOT</version>
    </parent>



# JDK11 + JBOSS7.2/7.4 + Distribució Github GovernIB

Per les solucions que utilitzin JDK11 i JBOSS 7.2/7.4 i a més al fer deploy pugin els artifacs a a la branca gh-pages https://github.com/GovernIB/maven, llavors de s'ha de fer que el pom arrel tengui el següent parent:

    <parent>
        <artifactId>caib-artifacts-jdk11-jboss72or74-with-github-governib-distribution</artifactId>
        <groupId>es.caib.maven</groupId>
        <version>1.0.1-SNAPSHOT</version>
    </parent>

En les dues configuracions anteriors es requereix afegir en el pom.xml el següent repositori:

    <repositories>
        <repository>
            <id>github_governib_maven</id>
            <name>GitHub GovernIB Maven Repository</name>
            <url>https://governib.github.io/maven/maven/</url>
        </repository>
    </repositories>


## Compilar productes per JBoss 7.2 o per JBoss 7.4

El productes finals (ears o wars) que tenguin parent "caib-artifacts" es poden construir per Jboss 7.2 o per JBoss 7.4.
Per defecte les construccions es fan per JBoss 7.2:
- mvn clean install: Construcció per Jboss 7.2 (Construcció per defecte)
- mvn clean install -Djboss=7.2: Construcció per JBoss 7.2 (Construcció explicita)
- mvn clean install -Djboss=7.4: Construcció per JBoss 7.4 (Construcció explicita)



## Com definir dependències segons si es compila per JBoss 7.2 o per JBoss 7.4

*NOTA IMPORTANT: Els profiles jboss72_def i jboss72_explicit han de ser sempre iguals !!!!!*
```
          <profiles>
    
        <!-- Profile jboss72: actiu per defecte -->
        <profile>
            <id>jboss72_def</id>
            <activation>
                <property>
                    <name>!jboss</name>
                </property>
            </activation>
            <dependencies>
                <!-- Dependències específiques per a JBoss 7.2 -->
                <dependency>
                    <groupId>javax.activation</groupId>
                    <artifactId>activation</artifactId>
                    <version>1.1.1.redhat-5</version>
                </dependency>
        
                <dependency>
                    <groupId>javax.persistence</groupId>
                    <artifactId>javax.persistence-api</artifactId>
                    <version>2.2.0.redhat-1</version>
                </dependency>

            </dependencies>
        </profile>

        <!-- Profile jboss72: actiu per propietat -->
        <profile>
            <id>jboss72_explicit</id>
            <activation>
                <property>
                    <name>jboss</name>
                    <value>7.2</value>
                </property>
            </activation>
            <dependencies>
                <!-- Dependències específiques per a JBoss 7.2 -->
                <dependency>
                    <groupId>javax.activation</groupId>
                    <artifactId>activation</artifactId>
                    <version>1.1.1.redhat-5</version>
                </dependency>
        
                <dependency>
                    <groupId>javax.persistence</groupId>
                    <artifactId>javax.persistence-api</artifactId>
                    <version>2.2.0.redhat-1</version>
                </dependency>
            </dependencies>
        </profile>

        <!-- Profile jboss74: actiu per propietat -->
        <profile>
            <id>jboss74_explicit</id>
            <activation>
                <property>
                    <name>jboss</name>
                    <value>7.4</value>
                </property>
            </activation>
            <dependencies>
                <!-- Dependències específiques per a JBoss 7.4 -->
                <dependency>
                    <groupId>jakarta.activation</groupId>
                    <artifactId>jakarta.activation-api</artifactId>
                    <version>1.2.2.redhat-00001</version>
                </dependency>
                <dependency>
                        <groupId>jakarta.persistence</groupId>
                        <artifactId>jakarta.persistence-api</artifactId>
                        <version>2.2.3.redhat-00001</version>
                </dependency>
            </dependencies>
        </profile>
    </profiles>
```







## Com saltar el deploy d'un mòdul maven (pom.xml)

Hi ha dues possibles formes de fer-ho

(1) Puntual: Afegir la següent propietat:
```
    <properties>
        <maven-site-plugin.skip>true</maven-site-plugin.skip>
    </properties>
```
(2) Sempre: Afegir el següent plugin dins pluginManagement
```
    <build>
        ...
            <plugins>
                ...
                <plugin>
                    <artifactId>maven-deploy-plugin</artifactId>
                    <configuration>
                        <skip>true</skip>
                    </configuration>
                </plugin>
                ...
            </plugins>
        ...
    </build>
```
