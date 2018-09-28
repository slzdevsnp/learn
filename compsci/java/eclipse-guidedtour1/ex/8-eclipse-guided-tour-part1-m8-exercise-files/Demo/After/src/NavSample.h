/*
 * NavSample.h
 *
 *  Created on: Jul 3, 2013
 *      Author: Tod
 */

#ifndef NAVSAMPLE_H_
#define NAVSAMPLE_H_
#include "TestInterface.h"
#include <string>

class NavSample: public TestInterface {
public:
	NavSample();
	virtual ~NavSample();
	void runYourTest();
	static void somePublicMethod();
	std::string TruncateMessage();


private:
	static void somePrivateMethod();
	static const unsigned int MAX_LENGTH = 5;
};
#endif /* NAVSAMPLE_H_ */
