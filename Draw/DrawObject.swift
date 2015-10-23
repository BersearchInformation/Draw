//
//  DrawObject.swift
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
maintain a stroke color and a fill color. Line objects will maintain a starting point, ending point and stroke color.
All objects will maintain objectBounds

*/




class DrawObject: NSObject, NSCoding {
    
    var objectBounds: CGRect =      CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    var strokeColor: NSColor =      NSColor.clearColor()
    
    init(objectBounds: CGRect, strokeColor:NSColor) {
        self.objectBounds = objectBounds
        self.strokeColor = strokeColor
    }
    
    required init(coder aDecoder: NSCoder) {
        objectBounds = aDecoder.decodeRectForKey("objectBounds")
        strokeColor = aDecoder.decodeObjectForKey("strokeColor") as! NSColor
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeRect(objectBounds, forKey: "objectBounds")
        aCoder.encodeObject(strokeColor, forKey: "strokeColor")
    }
    
    func draw() {
        // subclasses will override draw() to implement their drawing behaviour
    }
}