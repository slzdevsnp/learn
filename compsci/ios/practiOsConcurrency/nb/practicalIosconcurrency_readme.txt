title: practical iOS concurrency

macos  concurrent programing became easier with apple's apis



## chap 1  Intro and Overview

  NB! understand blocks,  dispatch queues, operations queues, custom  nsoperations

## chap 2 Creating and Using Blocks

  demo ch2-block-demo

  A block is an anonymous inline collection of code.

  has :
    * a typed argument lsit
    *  an inferred or declared return type

  can :
    * can  capture sture from lexial scope
    * can optionaly modify state of the lexical scope


    ex:
    //return type is int
    //^ is a block signifier
    //squareBlock  = variable name
    //(int) is a parameter list
    //  return num * num;  is a body of the block

    int (^squareBlock)(int) = ^int(int num) {
      return num * num;
    };


## chap 3 Dispatch Queues
  ch3-dispatchQueue-demo

  serial queues vs concurrent queues

    * serial queue usual usage : serialize  access to some shared resource

  concurrent queues.   OS has underlying responsibility to allocate an optimal number of threads for n concurrent
  queues

    * call dispatch_get_global_queue  func

    4 queues ( high, default, low, background)



## chap 4 Operations Queues
## chap 5 Creating NSOperation Subclasses
