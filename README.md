# CAIB Artifacts


Conjunt de pom amb les dependències i altres elements requerits pels projectes desenvolupats a la CAIB que utilitzin JDK11+JBOSS7.2 o JDK11+JBOSS7.2+DISTRIBUCIÓ_GITHUB_GOVERNIB_MAVEN.

# JDK11+JBOSS7.2

Per les solucions que utilitzin JDK11 i JBOSS 7.2 s'ha de fer que el pom arrel tengui el següent parent:

    <parent>
        <artifactId>caib-artifacts-jdk11-jboss72</artifactId>
        <groupId>es.caib.maven</groupId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>

Requereix afegir en el pom.xml el següent repositori:

    <repositories>
        <repository>
            <id>github_governib_maven</id>
            <name>GitHub GovernIB Maven Repository</name>
            <url>https://governib.github.io/maven/maven/</url>
        </repository>
    </repositories>


# JDK11 + JBOSS7.2 + Distribució Github GovernIB

Per les solucions que utilitzin JDK11 i JBOSS 7.2 i a més al fer deploy pugin els artifacs a a la branca gh-pages https://github.com/GovernIB/maven, llavors de s'ha de fer que el pom arrel tengui el següent parent:

    <parent>
        <artifactId>caib-artifacts-github-governib-distribution-with-jdk11-jboss72</artifactId>
        <groupId>es.caib.maven</groupId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>

Requereix afegir en el pom.xml el següent repositori:

    <repositories>
        <repository>
            <id>github_governib_maven</id>
            <name>GitHub GovernIB Maven Repository</name>
            <url>https://governib.github.io/maven/maven/</url>
        </repository>
    </repositories>


## Com saltar el deploy d'un mòdul maven (pom.xml)

(1) Afegir la següent propietat:
```
    <properties>
        <maven-site-plugin.skip>true</maven-site-plugin.skip>
    </properties>
```
(2) Afegir el següent plugin dins pluginManagement
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
