//
//  DrawView.swift
//  TouchTracker
//
//  Created by Sviatoslav Zimine on 5/5/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()


    func stroke(_ line: Line) -> Void {
        let path = UIBezierPath()
        // now path properties are @IBInspectables
        //path.lineWidth = 10
        path.lineWidth = lineThickness
        path .lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()	
    }

    override func draw(_ rect: CGRect) -> Void {
        //draw finished lines in black
        //UIColor.black.setStroke()  // @IBInspectable
        finishedLineColor.setStroke()
        for line in finishedLines {
            stroke(line)
        }
        
        // Draw current lines in red
        //UIColor.red.setStroke() // @IBInspectable
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            stroke(line)
        }
    }
    
    //a touch is a line with zero length
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

        // Log statement to see the order of events
        print(#function)
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Log statement to see the order of events
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        
        setNeedsDisplay()
    }
    
    //MARK: - customize line color, thickness
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness:  CGFloat = 10 {
        didSet{
            setNeedsDisplay()
        }
    }
    
}

