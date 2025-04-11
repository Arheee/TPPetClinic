 - les dépendances nécessaires à son exécution,
  - son port d’écoute,
  - ses variables d’environnement attendues,
  - ses interactions avec les autres services.


## spring-petclinic-api-gateway (<artifactId>)
Role : centralise les appels, les routes, applique des mecanismes
Source : pom.xml

# Dependances : 
- Spring boot et Actuator: 
spring-boot-devtools, spring-boot-configuration-processor, spring-boot-starter-actuator
- Cloud gateway : spring-cloud-starter-gateway
- Resilience : spring-cloud-starter-circuitbreaker-reactor-resilience4j, resilience4j-micrometer
- Tracage : spring-cloud-starter-zipkin
- Monitoring : wavefront-spring-boot-starter, jolokia-core, micrometer-registry-prometheus
- Assets web : angularjs, jquery, bootstrap, angular-ui-router, webjars-locator-core
- Utilitaires : spring-boot-starter-test, junit-jupiter-api, junit-jupiter-engine, mockwebserver
Source: pom.xml

# Port : ?? defaut 8080
Vérifier le parent 

# Variables d'env : 
app.customers.uri : Par défaut http://localhost:8082

app.vets.uri : Par défaut http://localhost:8083

app.visits.uri : Par défaut http://localhost:8084
(adresses des microservices auxquels api-gateway doit se connecter)
source : application.yl

# Interactions avec les autres services: 
- Redirige :
• /api/vet/** vers http://localhost:8083 (vets-service)
• /api/visit/** vers http://localhost:8084 (visits-service)
• /api/customer/** vers http://localhost:8082 (customers-service)
- Communication HTTP via RestTemplate et WebClient (définis dans ApiGatewayApplication.java)
source : application.yml et ApiGatewayApplication.java

########################################################

## spring-petclinic-customers-service

# Dependances: (pom.xml)
- Spring Boot : actuator, starter-data-jpa, starter-web, starter-validation, starter-test
- Spring Cloud : spring-cloud-starter-zipkin (pour le traçage, désactivé via la config)
- Persistance : mysql-connector-java (runtime), hsqldb (runtime)
- Monitoring : wavefront-spring-boot-starter, jolokia-core, micrometer-registry-prometheus
- Utilitaires : lombok
- Tests : junit-jupiter-api, junit-jupiter-engine, assertj-core

# Port: application.yml (server.port)
8082

# Varables d'env: (application.yml)
- Datasource : 
spring.datasource.initialization-mode, schema et data
- Profile MySQL
- Personnalisable : 
spring.datasource.url, 
spring.datasource.username 
spring.datasource.password

# Interactions avec les autres services : 
- Exposition REST : endpoints REST pour la gestion des clients
- Acces aux données : JPA 
- Integration : backend pour customers 


## vets-service
# Dependances: (pom.xml)
 - Spring Boot : starter-web, starter-validation, starter-actuator, starter-cache, starter-data-jpa, starter-test
- Spring Cloud : spring-cloud-starter-zipkin (pour le traçage, désactivé via la config)
- Cache et Persistance : javax.cache (cache-api), ehcache, hsqldb (runtime) et mysql-connector-java (runtime)
- Monitoring : wavefront-spring-boot-starter, jolokia-core, micrometer-registry-prometheus
- Utilitaires : lombok
- Tests : junit-jupiter-api et junit-jupiter-engine

# Port: application.yml (server.port)
8083

# Varables d'env: (application.yml)
- Datasource :
• Par défaut (HSQLDB) :
    - spring.datasource.initialization-mode: always
    - schema: classpath*:db/hsqldb/schema.sql
    - data: classpath*:db/hsqldb/data.sql
• En profil « mysql » :
    - schema: classpath*:db/mysql/schema.sql
    - data: classpath*:db/mysql/data.sql
 Caching : Configuration de spring.cache (cache-names: vets)
- JPA & Zipkin : jpa open-in-view false, ddl-auto none, zipkin.enabled false
- Wavefront & Management : Nom de l’application défini (petclinic) et endpoints health, info, prometheus exposés

# Interactions avec les autres services : 
 - Exposition REST : Fournit des endpoints pour la gestion des vétérinaires, destinés notamment à être appelés par l’API Gateway
 - Accès aux données : Utilise JPA
 - Cache : mise en cache nommés vets


## spring-petclinic-visits-service
# Dependances: (pom.xml)
- Spring Boot : starter-actuator, starter-data-jpa, starter-web, starter-validation, starter-test
- Spring Cloud : spring-cloud-starter-zipkin (pour le traçage, désactivé via la config)
- Monitoring et Observabilité : wavefront-spring-boot-starter, jolokia-core, micrometer-registry-prometheus
- Persistance : hsqldb (runtime) et mysql-connector-java (runtime)
- Utilitaires : lombok
- Tests : junit-jupiter-api, junit-jupiter-engine

# Port: application.yml (server.port)
8084

# Varables d'env: (application.yml)
- Datasource: 
• Par défaut (HSQLDB) :
    - spring.datasource.initialization-mode: always
    - schema: classpath*:db/hsqldb/schema.sql
    - data: classpath*:db/hsqldb/data.sql
• En profil « mysql » :
    - schema: classpath*:db/mysql/schema.sql
    - data: classpath*:db/mysql/data.sql
- JPA : open-in-view false, hibernate ddl-auto none
- Zipkin : désactivé (zipkin.enabled false)
- Wavefront & Management : configuration avec le nom d’application (petclinic) et endpoints health, info, prometheus exposés

# Interactions avec les autres services : 
- Exposition REST : Fournit des endpoints REST pour la gestion des visites, destinés notamment à être appelés par l’API Gateway
- Accès aux Données : Utilise Spring Data JPA



## PARENT
## spring-petclinic-k8s
Version : 2.3.3
Dependance (dependencyManagement) : 
 Import de spring-cloud-dependencies (version Hoxton.SR7) pour gérer les versions des dépendances Spring Cloud.
- Versionnement centralisé pour :
    • spring-boot-starter-test (avec exclusion de junit classique)
    • assertj-core
    • wavefront-spring-boot-starter (version 2.0.0), wavefront-sdk-java (version 2.6.2) et wavefront-opentracing-sdk-java (version 2.1.1)
