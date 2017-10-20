//
//  DeckerUtils.swift
//  DeckerWar
//
//  Created by vitalii on 13/10/2017.
//  Copyright © 2017 vitalii. All rights reserved.
//

import Foundation
class DeckerUtils {
    static func getPointsOfArea(row:Int, col:Int, decker: Decker, deckerDirection: DeckerDirection) -> (Int, Int, Int, Int) {
        switch deckerDirection {
        case .east:
            return (row-1, col-decker.cellAmount, row+1, col+1)
        case .west:
            return (row-1, col-1, row+1, col+decker.cellAmount)
        case .south:
            return (row-1, col-1, row+decker.cellAmount, col+1)
        case .north:
            return (row-decker.cellAmount, col-1, row+1, col+1)
        }
    }
    
    static func getPointsOfDecker(row:Int, col:Int, decker: Decker, deckerDirection: DeckerDirection) -> (Int, Int, Int, Int) {
        switch deckerDirection {
        case .east:
            return (row, col-decker.cellAmount+1, row, col)
        case .west:
            return (row, col, row, col+decker.cellAmount-1)
        case .south:
            return (row, col, row+decker.cellAmount-1, col)
        case .north:
            return (row-decker.cellAmount+1, col, row, col)
        }
    }
    
    static func printDeckers(deckerGenerator: DeckerGenerator){
        for i in 0...deckerGenerator.rows-1 {
            for j in 0...deckerGenerator.columns-1 {
                if deckerGenerator.occupiedCells[i][j] {
                    print("X", terminator: "")
                } else {
                    print("O", terminator: "")
                }
            }
            print("")
        }
        print("")
    }
}
