# CAIB Artifacts


Conjunt de pom amb les dependències i altres elements requerits pels projectes desenvolupats a la CAIB que utilitzin JDK11+JBOSS7.2 o JDK11+JBOSS7.2+DISTRIBUCIÓ_GITHUB_GOVERNIB_MAVEN.

# JDK11+JBOSS7.2

Per les solucions que utilitzin JDK11 i JBOSS 7.2 s'ha de fer que el pom arrel tengui el següent parent:

    <parent>
        <artifactId>caib-artifacts-jdk11-jboss72</artifactId>
        <groupId>es.caib.maven</groupId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>


# JDK11 + JBOSS7.2 + DISTRIBUCIÓ_GITHUB_GOVERNIB_MAVEN

Per les solucions que utilitzin JDK11 i JBOSS 7.2 i a més al fer deploy pugin els artifacs a a la branca gh-pages https://github.com/GovernIB/maven, llavors de s'ha de fer que el pom arrel tengui el següent parent:

    <parent>
        <artifactId>caib-artifacts-github-governib-distribution-with-jdk11-jboss72</artifactId>
        <groupId>es.caib.maven</groupId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>
