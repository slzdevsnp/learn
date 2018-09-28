//
//  DrawView.swift
//  TouchTracker
//
//  Created by Sviatoslav Zimine on 5/5/17.
//  Copyright © 2017 szimine. All rights reserved.
//

import UIKit

class DrawView: UIView , UIGestureRecognizerDelegate {
    
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    var selectedLineIndex: Int? {
        didSet {
            if selectedLineIndex == nil {
                let menu = UIMenuController.shared
                menu.setMenuVisible(false, animated: true)
            }
        }
    }
    
    var moveRecognizer: UIPanGestureRecognizer!
    
    override var canBecomeFirstResponder: Bool{
        return true
    }

    //for double tap
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self,
                                                         action: #selector(DrawView.doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(DrawView.tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(DrawView.longPress(_:)))
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self,
                                                action: #selector(DrawView.moveLine(_:)))
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
        
        
    }

    
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
        finishedLineColor.setStroke()
        for line in finishedLines {
            stroke(line)
        }
        
        // Draw current lines in red
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            stroke(line)
        }
        if let index = selectedLineIndex {
            UIColor.green.setStroke()
            let selectedLine = finishedLines[index]
            stroke(selectedLine)
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
    
    //MARK: - select a line
  
    
    func doubleTap(_ gestureRecognizer: UIGestureRecognizer){
        print(#function)
        currentLines.removeAll()
        finishedLines.removeAll()
        selectedLineIndex = nil
        setNeedsDisplay()
    }
    
    
    
    
    func tap(_ gestureRecongizer: UIGestureRecognizer){
        print(#function)
        
        let point = gestureRecongizer.location(in: self)
        selectedLineIndex = indexOfLine(at: point)

         //grab the menu controller 
        let menu = UIMenuController.shared
        if selectedLineIndex != nil {
            //make DrawView the target of menu item action messages
            becomeFirstResponder()
            
            //create a new "delete" UIMenuItem  with an action
            let deleteItem = UIMenuItem(title: "Delete",
                                        action: #selector(DrawView.deleteLine(_:)))
            menu.menuItems = [deleteItem]
            
            //tell the menu where it should come from and show it
            let targetRect = CGRect(x: point.x, y: point.y, width: 2, height: 2)
            menu.setTargetRect(targetRect, in: self)
            menu.setMenuVisible(true, animated: true)
        }else{
            menu.setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }

    func longPress(_ gestureRecogniser: UILongPressGestureRecognizer){
        print(#function)
        
        if gestureRecogniser.state == .began{
            let point = gestureRecogniser.location(in: self)
            selectedLineIndex = indexOfLine(at: point)
            
            if selectedLineIndex != nil {
                currentLines.removeAll()
            
            }else if gestureRecogniser.state == .ended {
                selectedLineIndex = nil
            }
            
            setNeedsDisplay()
        }
    }
    
    func deleteLine(_ sender: UIMenuController) {
        //remove the selected line from the list of fnished lines
        if let index = selectedLineIndex {
            finishedLines.remove(at: index)
            selectedLineIndex = nil
            //redraw evertyhing
            setNeedsDisplay()
        }
        
    }

    func moveLine(_ gestureRecognizer: UIPanGestureRecognizer) {
        print("recognized a pan")

        //if a line is selected
        if let index = selectedLineIndex {
            //when the pan recognizer changes its position.. 
            if gestureRecognizer.state == .changed{
                //how far has the pan moved?
                let translation = gestureRecognizer.translation(in: self)
                
                //add translation to the current begin and end points of the line
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x   += translation.x
                finishedLines[index].end.y   += translation.y
                
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                //redraw screen
                setNeedsDisplay()
            }
        }else{
            //if no line selected do nothing
            return
        }
    }

    //implement method from delegate protocol
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    
    
    func indexOfLine(at point: CGPoint) -> Int? {
        for (index, line) in finishedLines.enumerated() {
            let begin = line.begin
            let end = line.end
            
            //check a few poitns on the line
            for t in stride(from: CGFloat(0), to: 1.0, by: 0.05) {
                let x = begin.x + t * (end.x - begin.x)
                let y = begin.y + t * (end.y - begin.y)
                
                //if the tapped point is withing 20 points, lets return this line
                if hypot(x - point.x , y - point.y )  < 20.0 {
                    return index
                }
            }
        }
        //if nothing is close enough to the tapped point, we did not select a line
        return nil
    }
    
}

