# Repositori Maven software CAIB (GovernIb Github Maven Repository)
Repositori maven de tots els projectes de la CAIB

No conté codi font. Només la branca gh-pages conté els jar, wars, ears i d'altres dependències dels projectes CAIB que compilen emprant MAVEN.

Per fer ús de les llibreries d'aquest repositori maven només s'ha d'incloure la següent entrada al pom arrel del projecte:
```
       <repositories>
           <repository>
             <id>github-governib-maven-repos</id>
             <name>GitHub GovernIB Maven Repository</name>
             <url>https://governib.github.io/maven/maven/</url>
           </repository>
        </repositories>
```

Tot projecte CAIB, desenvolupat en maven, al final del pom.xml ha d'incloue aquests blocs de codi que serveixen per deployar (pujar a aquest repositori maven) els diferents jar, wars o ears dels projectes:

```
  <build>
    <plugins>
    
      ...
    
      <plugin>
        <artifactId>maven-deploy-plugin</artifactId>
        <version>2.8.1</version>
        <configuration>
          <altDeploymentRepository>
            internal.repo::default::file://${project.build.directory}/mvn-repo
          </altDeploymentRepository>
        </configuration>
      </plugin>

      <plugin>
        <groupId>com.github.github</groupId>
        <artifactId>site-maven-plugin</artifactId>
        <version>0.12</version> 
        <configuration>
          <!-- git commit message -->
          <message>Maven artifacts for ${project.version}</message> 
          <outputDirectory>${project.build.directory}/mvn-repo</outputDirectory> 
          <noJekyll>true</noJekyll>   
          <!-- remote branch name -->
          <branch>refs/heads/gh-pages</branch> 
          <includes>
            <include>**/*</include>
          </includes>
          <path>maven</path>
          <!-- github repo name -->
          <repositoryName>maven</repositoryName>      
          <!-- github username or organization  -->
          <repositoryOwner>GovernIB</repositoryOwner>    
          <server>github_governib_maven</server>
          <merge>true</merge>
          <dryRun>false</dryRun>
        </configuration>
        <executions>
          <execution>
            <goals>
              <goal>site</goal>
            </goals>
            <phase>deploy</phase>
          </execution>
        </executions>
      </plugin>

    </plugins>
  </build>
  
  <distributionManagement>
    <repository>
      <id>github_governib_maven</id>
      <name>GitHub GovernIB Maven Repository</name>
      <url>file://${project.build.directory}/mvn-repo</url>
    </repository>
  </distributionManagement>
  
  
  <!--   COM UTILITZAR: AFEGIR AQUEST CODI AL pom.xml    -->
  <!--
        <repositories>
           <repository>
             <id>github-governib-maven-repos</id>
             <name>GitHub GovernIB Maven Repository</name>
             <url>https://governib.github.io/maven/maven/</url>
           </repository>
        </repositories>
  -->
  ```

<table>
<tr><td>
</td></tr>
</table>




# Certificats GOIB

La solució a errors d'aquest tipus  ```Caused by: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target``` la podeu trobar [AQUÍ](https://github.com/GovernIB/maven/tree/binaris/certificatsgoib)



#CAIB Artifacts
Conjunt de pom amb les dependències i altres elements requerits pels projectes desenvolupats a la CAIB que utilitzin JDK11+JBOSS7.2 o JDK11+JBOSS7.2+DISTRIBUCIÓ_GITHUB_GOVERNIB_MAVEN.

Més detalls [aquí](https://github.com/GovernIB/maven/tree/caib-artifacts)

