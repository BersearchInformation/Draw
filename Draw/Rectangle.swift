//
//  Rectangle.swift
//  Draw
//
//  Created by Tom Bernard on 10/18/15.
//  Copyright (c) 2015 Bersearch Information Services. All rights reserved.
//

/*

Hillegass, A., Preble, A., Chandler, N.,
Cocoa Programming for OS X, The Big Nerd Ranch Guide
Pearson Technology Group, Indianapolis, Fifth Edition,
first printing, April 2015
Chapter 18, p 303, Challenge

Draw

*/

import Cocoa

/*

A draw document will support drawing of oval, rectangle and line objects. Oval and Rectangle objects will
maintain a stroke color and a fill color. All objects will maintain objectBounds

*/


class Rectangle: DrawObject {

    var fillColor: NSColor =    NSColor.clearColor()
    
    init(objectBounds: CGRect, strokeColor:NSColor, fillColor: NSColor) {
        super.init(objectBounds: objectBounds, strokeColor: strokeColor)
        self.fillColor = fillColor
    }

    required init(coder aDecoder: NSCoder) {
        fillColor = aDecoder.decodeObjectForKey("fillColor") as! NSColor
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(fillColor, forKey: "fillColor")
        super.encodeWithCoder(aCoder)
    }
    

    override func draw() {
        let path = NSBezierPath(rect: objectBounds)
        fillColor.set()
        path.fill()
        strokeColor.set()
        path.stroke()
    }

    
}
