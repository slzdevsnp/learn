
spring cloud fondamentals   


demos on:

service discovery  

distributed configuration

client-side load balancing

intellingent routing

fault  tolerance 

### overview

ch Getting Familiar with spring cloud
ch Finding services using service discovery
ch Configuring services using distributed configuration
ch Mapping services using inelligent routing
ch Calling services using client-side load balancing
ch Creating self-healing services with circuite breaker
ch Bringing it all together and where to go next

################


ch Getting Familiar with spring cloud
	spring cloud helps you build cloud-native applications
	spring cloud : 
		spring cloud bus
		spring cloud config
		spring cloud cluster
		spring cloud stream
		spring cloud netflix
		spring cloud sleuth

	course scope:  spring cloud config, spring cloud netflix
		course targets
			service discovery
			distribued configuration
			intelligent routing
			client-side load balancing
			circuit breaker pattern

	http://dustin.schultz.io/ps-scf			

	prerequisitory knowledge
		java 8,  spring boot, knowlege of understainding microservices, sts  v >= 3.8.x


ch Finding services using service discovery

	how spring cloud implements service discovery via netflix project eureka ?
	how 1 service locates another service ?  <== service discovery
	service discovery provides:
		a way for a service to register itself
		a way for a service t deregister itself
		a way for a client t find other services
		a way to check the healt of a service  and remove unhealthy instances

		discover services with
			spring cloud consul
			spring cloud zookeeper
			spring cloud netflix   <-- a focus of this course
					spring cloud netflix  eureka server and  eureka client

		key components in service discovery
			discovery server  (a resistry of service locations) one or more instances 
			service
			client

		demo : eureka server   
			 in http://start.spring.io  project name: discovery-server, 
			 include for dependencies: eureka server, devtools, actuator
			 in main.resources.application.properties set the expected properties
			 => springboot starts the eureka server		

		demo : eureka service
				in http://start.spring.io  project name service, deps, eureka discovery, devtools, actuator  spring boot version 1.5.10
			   create config for instance 1 and 2 
			   start them both.   + start discovery  server
			   -> you should see both instances gettting registered
			 