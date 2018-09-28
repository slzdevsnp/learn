//
//  EmployeeTest.swift
//  Copyright © 2017 roga_kopyta. All rights reserved.
//

import Foundation
//-----------------------------------------------------

func testEmployee() {

    let barney = Employee ( name : "Barney",
                            payGrade:1 )
    

    
    let fred = Employee ( name : "Fred",
                          payGrade:2 )
    
    
     //print("\(fred)")
     //debugPrint("\(barney)")
  
    //using of assets
    assert( "\(fred)" == "Fred")
    assert( "\(barney.debugDescription)" == "Barney:1")
    
    assert ( fred == Employee(name:"Fred", payGrade:2))
    
    assert ( fred != barney ) //do not need to overload != 
                                //as  == is overloaded
    
    assert ( barney <  fred )
    assert ( barney <=  fred )
    assert ( fred   >   barney )
    assert ( fred   >= fred )
    assert ( fred   >= barney )

    var employees = [
        fred,
        barney,
        Employee(name:"Jessica", payGrade: 4),
        Employee(name:"George", payGrade: 3)
    ]
    print("testing sorting of employees")
    employees.sortInPlace() // from Comparable
    for person in employees {
        print("-->\(person)")
    }
    
    let dict = [fred:"fred", barney:"barney"] //needs Hashable protocol
    assert ( dict[fred] == "fred")
    assert ( dict[barney] == "barney")
    
    
    print("testEmployee(): pass")
}

