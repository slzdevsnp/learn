name: creating your first spring boot application

course outline

ch1 oveview
ch2 creating your fist spring boot project
ch3 creating webapps
ch4 configuring and accessing a data source
ch5 testing the spring boot project


pre-reqs
java
some spring fundamentals

post-reqs
java, core spring and spring mvc
spring data, jpa and spring jdbc
front end applications technologies like angular or react

demo project   maven based  das-boot project


ch2 creating your fist spring boot project

	spring boot large topic
	spring boot is a game changer
	demo app: das boot app, list sunken boats

	prereqs
		jdk 1.8, maven, 
	pom.xml
		  the  parent section with spring-boot  with version1.3.1.RELEASE	
		  dependency  spring-boot-starter-web  (gets web mvmc autoconfigured)
	org.szi.boot.App  @SpringBootApplicaiton annotation	  
	org.szi.boot.App
	org.szi.boot.controller.HomeController
	org.szi.boot.App <- RunApp  (starts spring )
	in browser  http://localhost:8080   (see the  home controller string)

	learning path for spring boot
	spring reference   http://spring.io
	pluralsight courses about spring
		spring fundamentals  hansen
		introduction to spring mvc4 hansen
		spring security fundamentals
		spring with java and hibernate hanse
		getting started with spring data jpa bunker
		getting started with spring data rest bunker

	spring boot dependency management	
			BOM  bill of materials
			example  spring-core 4.2.3 works well with logback-core 1.1.3
			<parent> section  specified the version of 1.3.1  of spring-boot-starter 
				this sets hierarchy dependencies !!

	other spring initializers !!
	http://start.spring.io  (Switch to the full version)  
	 to build a custom project  pom !!
	spring boot cli  (command line tool)			
    >sdk install springboot
    >spring --version
    >spring init --dependencies=web myNewApp   # to generate a skeleton app project with pom.xml
    examples of skeleton projects 
    https://github.com/spring-projects/spring-boot/tree/master/spring-boot-samples

    how it works  (much less configuration than before) 
    java main method = entry point,  sprint context  (initializes) embedded server (default is tomcat)
    @SpringBootApplication  annotation wraps commonly usedd annotations @Configuration, @EnableAutoConfiguration @ComponentScan
    its best to keep  App class at the top of packages (for component scanning)

ch3 creating webapps
    #setting up the webapp front-end code
	git clone https://github.com/dlbunker/ps-spring-boot-resources.git

    demo
    copy ps-spring-boot-resources/client/www/*   to das_boot/src/main/resoures/public
    http://localhost:8080/index.html#/

    right-click -> Inspect -> Console

    adding a controller for a url org.szi.boot.controller.ShipWreckController
    	create Rest endpoints list(), create(), get(), update(), delete()


	application.properties (place on classpath root)
    environmental configuration ( application-profile.properties)

    docs (google it)
    spring-boot common application properties
  
    demo:
    1.create under ressources  application.properties, application-TST.properties, application-PRD.properties
    2. in launch shell scripts add VM variable
     org.szi.boot.App  -Dspring.profiles.active=PRD   
     org.szi.boot.App  -Dspring.profiles.active=TST

ch4 configuring and accessing a data source
	demo:
		add dependencies in pom.xml   in maven projects window -> Dependencies
        spring-boot-starter-data-jpa,  h2
        enable in application.properties   spring.h2.console.enabled=true  spring.h2.console.path=/h2 
        go to localhost:8080/h2  to see the h2 schema

    demo flyway db:    
    pom dependency  flyway-core
    addd additional values in application.properties
    add resources/db/migration/V2__create_shipwreck.sql  //with create table ddl -> app restarted, you see new table in h2 schema
   
    demo defining multiple datasources
    org.szi.boot.config

    demo adding JPA
    repository.ShipwreckRepository
    rework  controller.ShipWreckController

ch5 testing the spring boot project

	add pom dependency spring-boot-starter-test    
		brings a host  of dependencies, junit, mockito,, hamcreset 
        !! <scope>test</scope>
        write first junit test
        test/java/org.szi/boot/AppTest 
        then either run this class,  or do  maven  test
        or in cmdline from the top of the project:  mvn test  , mvn clean compile test

        !! ShipWreckControllerTest   has a testShipWreckGet() setUp with mockito, hamcrest

        integration testing challenges
        	database state needs to be consistent
        	app/test startup can be slow
        demo integration teting
        ShipwreckRepositoryIntegrationTet  starts the  app	
        
        demo  Web integration testing
        !! ShipwreckControllerWebIntegrationTest   tests the actuall rest call and the json response


