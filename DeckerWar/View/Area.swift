//
//  Area.swift
//  DeckerWar
//
//  Created by vitalii on 13/10/2017.
//  Copyright © 2017 vitalii. All rights reserved.
//

import UIKit

class Area :UIView {
    var deckers: UIBezierPath?           { didSet { setNeedsDisplay() } }
    var deckersColor: UIColor = .red    { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        // stroke the path
        let width = 300
        let height = 300
        let step = 30
        let rows = 10
        let columns = 10
        
        let field = UIBezierPath()
        
        //draw borders
        field.lineWidth = 1
        field.move(to: CGPoint(x: 0, y: 0))
        field.addLine(to: CGPoint(x: 0, y: height))
        field.addLine(to: CGPoint(x: width, y: height))
        field.addLine(to: CGPoint(x: width, y: 0))
        field.addLine(to: CGPoint(x: 0, y: 0))
        
        //draw field grid
        for i in 0...rows-1 {
            field.move(to: CGPoint(x: i*step, y: 0))
            field.addLine(to: CGPoint(x: i*step, y: height))
        }
        for j in 0...columns-1 {
            field.move(to: CGPoint(x: 0, y: j*step))
            field.addLine(to: CGPoint(x: width, y: j*step))
        }
        
        let fieldColor: UIColor = .blue
        fieldColor.setStroke()
        field.stroke()
        
        deckersColor.setStroke()
        deckers?.stroke()
    }
    
    func addDeckerCell(path: UIBezierPath, x:Int, y:Int, step:Int){
        path.move(to: CGPoint(x: x*step, y: y*step));
        path.addLine(to: CGPoint(x: x*step+step, y: y*step+step))
        path.move(to: CGPoint(x: x*step+step, y: y*step));
        path.addLine(to: CGPoint(x: x*step, y: y*step+step))
    }
    
    func drawDeckers(deckerGenerator: DeckerGenerator){
        let step = 30;
        
        let deckers = UIBezierPath()
        //draw deckers
        for i in 0...deckerGenerator.rows-1 {
            for j in 0...deckerGenerator.columns-1 {
                if deckerGenerator.occupiedCells[i][j] {
                    addDeckerCell(path: deckers, x: i, y: j, step: step)
                }
            }
            
        }
        self.deckers = deckers
    }
}
