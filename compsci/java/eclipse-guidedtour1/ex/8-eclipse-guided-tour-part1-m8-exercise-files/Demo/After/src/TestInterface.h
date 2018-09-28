/*
 * TestInterface.h
 *
 *  Created on: Jul 25, 2013
 *      Author: Tod
 */

#ifndef TESTINTERFACE_H_
#define TESTINTERFACE_H_

class TestInterface {
public:
	virtual ~TestInterface(){};
	virtual void runYourTest()=0;
};

#endif /* TESTINTERFACE_H_ */
