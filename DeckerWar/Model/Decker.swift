//
//  Decker.swift
//  TestMobile
//
//  Created by vitalii on 02/10/2017.
//  Copyright © 2017 vitalii. All rights reserved.
//

import Foundation



protocol Decker {    
    var cellAmount: Int { get }
    //var type: DeckerShape { get }
}

enum DeckerShape {
    case line
    case custom
}

enum DeckerDirection : Int {
    case east = 1
    case west
    case south
    case north
    
    static func getSize() -> Int {
        return 4
    }
}


