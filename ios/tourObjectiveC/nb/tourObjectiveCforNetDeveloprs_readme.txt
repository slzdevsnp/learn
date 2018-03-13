## plural title:
A tour of objective-c for .NET Developers

use Xcode (9)

chap 1. App development tour

	create new projet
	Single View App
	product name: Tekpub Mobile App
	Company identifier com.tekpub
	class preifx TPB !!(no in xcode9
	Objective-C
	Device Family iPhone

	delete storyboard files
	add new File   User Interface type View  name ViewController adds  ViewController.xib
	in App General Config  set Main Interface  to nothing (empty value)
	ViewControler.xib in File's Owner Identity inspector  associate it to your ViewController class

	from File's Owner  connectitions inspect  connect th view outlet to the main xib's View   Expects  an outlet  view <-> View

	connection actions or  outlets is done with CtrlClick
	connect  press This button  to ViewController.h   action  named didTapButton

	Add the follwoing code in  AppDelegate.m to instantiate your ViewController as the main window

////////////
#import "ViewController.h"


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Viewcontroller is your class connected to xibyou want to be displayed first
    ViewController *viewController = [[ViewController alloc]initWithNibName:@"FirstView" bundle:nil];  // FirstView as xib's fileName
    // set it as the root view controller of the application's window
    [self.window setRootViewController:viewController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

	Ctrl-Cmd - Up arrow  switch from h  to m  implementation file

	connect  the HelloRob label  to  ViewController.h   as outlet  named welcome label

chap 2  Strings

chap 3 Numbers
chap 4 Dates

chap 5 Loops,Structures, Arrays
	chap 2,3,4,5  create 1 project of type CommandLine using Objective-C call it primitivesArrays


chap 6 Queries and Data

create an ios singleview app   replace main storyboard by MainView xib , connect its view. instantiate the ViewController class
in AppDelegate.m  disable automatic reference counting in Build Settings, in Build phases link  a libary libsqlite3

mkdir ../prj/objectivec/iphoneDB
cd  ../prj/objectivec/iphoneDB
>/usr/bin/sqlite3 northwind.db
.schema
CREATE TABLE products(id int primary key, name text, description text);
insert into products values(1, "Ben's Date Juice", "Stuff we like for dates");
insert into products values(2, "Rob's Chicken Slayer", "have too many chickens?");

select * from products;

now create a new Group called Resources (make sure it points to a new physical folder Resources at the top of the project)
in Finder drag  northinwd.db   from iphoneDB/ to  Resources
make sure it is check for TekPubData Target Membership  (ensures it twill be in that bundle)

#########  outside  cocoa pods ###########
need to install to the project the FMDB dependency  with cocoapod
tutorial from https://cocoapods.org/
$ sudo gem install cocoapods

in the xcode project topfolder create a textfile named PodFile
e.g.
///
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'AFNetworking', '~> 2.6'
  pod 'ORStackView', '~> 3.0'
  pod 'SwiftyJSON', '~> 2.3'
end
///
or run
$pod init
now install the dependencies in your project with
$pod install

############## cocoa pods end ###########

ios project code contains example how to access sqlite db how to read and write data from it

chap 7 Remote Data with JSON

demo in ch7-json

topcoursedir/resetsrv  project needs to be running to expose a dummyrest service
which returns a json  (from within intellij)

recreated the project TekPubNetworking

added to info.plist before the ending of the root  dict
<key>NSAppTransportSecurity</key>
<dict>
		<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>

in  top of the course project  located the restsrv project to run rest basic services in GlassFish  started from intellij



chap 8 Ben Goes Full Speed
demo in ch8-fullspeed

topcoursedir/resetsrv  project needs


NB! invest in tableview, tabledatasource learning because they are used in almost any app

fetching data from networked json is refactored in a nicer way
json parsing is refactored
new class is created to model an entity
tableview is wired with entity instances
