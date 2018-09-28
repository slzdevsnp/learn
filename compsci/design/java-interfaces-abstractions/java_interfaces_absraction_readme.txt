#java interfaces absraction

ch: 01 cours overview
ch: 02 indroducing java abstractio mechanism
ch: 03 understanding the need for abstractions
ch: 04 extending your code through interfaces
ch: 05 implementing intefaces in different modules
ch: 06 recognizing the dangers of over-abstraction
ch: 07 conclusion


ch: 01 cours overview

	prereqs
		know how to write java code

ch: 02 indroducing java abstractio mechanism


	avoid to much responsibility on 1 class or method

	!! demo
	demo 1: org.szi.lrn.m2_intro_java_abtsr_mechanism.notabsract.RevenueCalculatorRunner
	
	demo 2: org.szi.lrn.m2_intro_java_abtsr_mechanism.withabstractclass.RevenueCalculatorRunner


	prefer interfaces to Abstract classes most of the time

	abstract classes are useful if you need to share  the behavior


ch: 03 understanding the need for abstractions


	abstractions are
		a way to arrange code
		suppress details
		simplify interactions between classes
		improves maintenance
		-> promotes decoupling

    code with abstractions  improves readability and code comprehension

    abstractions do not need interfaces:
    	structed abstraction (decompose complex problem in several simpler steps)
    	class absractrion  (delegate responsibility to other classes)
    	polymorphism (absraction layer can have different implementations)

	!! demo
	demo1: revenueCalculator imlemented with interface
	org.szi.lrn.m3_understand_need4abstraction.revenue.SalesPredictorRunner 
    
    demo2: anaimals  Animal.draw() method is composed of simpler steps
    org.szi.lrn.m3_understand_need4abstraction.animals.AnimalApplicationRunner


ch: 04 extending your code through interfaces

	principles of using interfaces:
		needed
		watertight (not leaky)
		simplify through encapsulation
			gauge that it's realy simpler
			encapsulate completely
		single responsibility


ch: 05 implementing intefaces in different modules

	!! demo
	demo1  ClientEngagementRepository implemented as csv   as junit tests
	test:  org.szi.lrn.m4_5_implment_intf_in_dif_modules.csv.CsvClientEngagementRepositoryTest

	demo2  ClientEngagementRepository implemented as hsqldb database   as junit tests
	test: org.szi.lrn.m4_5_implment_intf_in_dif_modules.database.DatabaseClientEngagementRepositoryTest


ch: 06 recognizing the dangers of over-abstraction
    consume absractions with moderation

	false abstractions
	poor naming
	single implementation
	incomplete implementation
	YAGNI  (you ain't gonna need it)

	!!demo
	  overabstraction  case
	  demos in reference with abstractions overengineered  before_complex, after_complex

ch: 07 conclusion


	dependency injection
		in the constructor of the class one of the argurments is another class
	testing stubs and mocks
		implement interfaces which MIMIC  the behavior of an app

