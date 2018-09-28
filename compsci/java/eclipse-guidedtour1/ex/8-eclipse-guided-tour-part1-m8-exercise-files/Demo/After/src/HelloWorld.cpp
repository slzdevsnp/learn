//============================================================================
// Name        : HelloWorld.cpp
// Author      : Tod Gentille
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <string>
#include "NavSample.h"

namespace {

const std::string GREETING = "Hello World!";

}

using std::cout;
using std::endl;

int main() {
	cout << GREETING << endl; // prints Hello World!
	NavSample nav_sampler;
	nav_sampler.runYourTest();

	NavSample::somePublicMethod();
	return 0;
}

