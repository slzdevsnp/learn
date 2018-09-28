/*
 * NavSample.cpp
 *
 *  Created on: Jul 3, 2013
 *      Author: Tod Gentille
 */

#include "NavSample.h"
#include <iostream>
#include <string>
static const std::string TEST_MESSAGE = "runTest has run \n";
NavSample::NavSample() {
	// TODO Auto-generated constructor stub
}

NavSample::~NavSample() {
	// TODO Auto-generated destructor stub
}

void NavSample::somePrivateMethod() {

}

std::string NavSample::TruncateMessage() {
	std::string msg;
	if (TEST_MESSAGE.length() > MAX_LENGTH) {
		msg = TEST_MESSAGE.substr(0, MAX_LENGTH);
	} else {
		msg = TEST_MESSAGE;
	}
	return msg;
}

void NavSample::runYourTest() {

	std::string msg = TruncateMessage();
	std::cout << msg;
}
//Example Comment with Description about what this method does
//Could also add usage note
void NavSample::somePublicMethod() {
	int i = 0;
	while (i < 10) {
		++i;
	}

}
