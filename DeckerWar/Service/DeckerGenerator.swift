//
//  DeckerGenerator.swift
//  TestMobile
//
//  Created by vitalii on 02/10/2017.
//  Copyright © 2017 vitalii. All rights reserved.
//

import Foundation
import UIKit

enum MyError: Error {
    case UnsupportedShape
    case UnexpectedBehaviour
}

class DeckerGenerator {
    let columns = 10
    let rows = 10
    let magicNumber = 100
    
    private(set) var occupiedCells = Array<Array<Bool>>()
    
    init(){
        //fill in array with 'empty' cells
        for _ in 0...rows-1 {
            var array = Array<Bool>()
            for _ in 0...columns-1 {
                array.append(false)
            }
            occupiedCells.append(array)
        }
    }
    
    func generateDeckers(deckers:Array<Decker>) {
        let sortedDeckers = deckers.sorted(by: { $0.cellAmount > $1.cellAmount })
        for decker in sortedDeckers {
            var success = false
            var trials = 0;
            while (!success) {
                if trials > magicNumber {
                    success = forceDraw(decker: decker)
                } else {
                    success = randomDraw(decker: decker)
                    trials+=1;
                }
            }
        }
    }
    
    private func tryToOccupyCells(row:Int, col:Int, decker:Decker, deckerShape:DeckerShape) throws -> Bool {
        var result = true
        switch deckerShape {
        case .line:
            for direction in 1...DeckerDirection.getSize() {
                let deckerDirection = DeckerDirection(rawValue: direction)!
                result = isAreaFree(row: row, col: col, decker: decker, deckerDirection: deckerDirection)
                if result {
                    occupyCells(row: row, col: col, decker: decker, deckerDirection: deckerDirection)
                    break
                }
            }
        case .custom:
            throw MyError.UnsupportedShape
        }
        return result
    }
    
    private func isAreaFree(row:Int, col:Int, decker:Decker, deckerDirection: DeckerDirection) -> Bool {
        var result = true
        let (firstRow, firstCol, lastRow, lastCol) = DeckerUtils.getPointsOfArea(row: row, col: col, decker: decker, deckerDirection: deckerDirection)
        let isValid = isAreaValid(firstRow: firstRow, firstCol: firstCol, lastRow: lastRow, lastCol: lastCol)
        if (!isValid) {
            return isValid
        }
        
        for i in firstRow...lastRow {
            for j in firstCol...lastCol {
                if !isPointValid(row: i, col: j){
                    continue
                }
                if occupiedCells[i][j] == true {
                    result = false
                    break
                }
            }
            if !result {
                break
            }
        }
        return result
    }
    
    private func isAreaValid(firstRow:Int, firstCol:Int, lastRow:Int, lastCol:Int) -> Bool{
        return !(firstRow < -1 || firstCol < -1 || lastRow > rows || lastCol > columns)
    }
    
    private func isPointValid(row:Int, col:Int) -> Bool{
        return !(row < 0 || col < 0 || row >= rows || col >= columns)
    }
    
    private func occupyCells(row:Int, col:Int, decker:Decker, deckerDirection: DeckerDirection) {
        let (firstRow, firstCol, lastRow, lastCol) = DeckerUtils.getPointsOfDecker(row: row, col: col, decker: decker, deckerDirection: deckerDirection)
        for i in firstRow...lastRow {
            for j in firstCol...lastCol {
                occupiedCells[i][j] = true
            }
        }
    }
    
    private func randomDraw(decker: Decker) -> Bool{
        var success = false
        let row = Int(arc4random_uniform(UInt32(rows*magicNumber)))%rows
        let column = Int(arc4random_uniform(UInt32(columns*magicNumber)))%columns
        do {
            print("Try for point: \(row), \(column)")
            success = try self.tryToOccupyCells(row: row, col: column, decker: decker, deckerShape: DeckerShape.line)
        } catch {
            print("Something wrong with algorithm.")
        }
        return success
    }
    
    private func forceDraw(decker: Decker) -> Bool{
        print("Force repaint will be performed for \(decker.cellAmount)-decker")
        DeckerUtils.printDeckers(deckerGenerator: self)
        var success = false
        let row = 0
        let column = 0
        for i in row..<rows {
            for j in column..<columns {
                do {
                    print("Try for point: \(i), \(j)")
                    success = try self.tryToOccupyCells(row: i, col: j, decker: decker, deckerShape: DeckerShape.line)
                } catch {
                    print("Something wrong with algorithm.")
                }
                if success {
                    return success
                }
            }
        }
        return success
    }
    
    
}
