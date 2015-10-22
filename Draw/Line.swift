//
//  Line.swift
//  Draw
//
//  Created by Tom Bernard on 10/18/15.
//  Copyright (c) 2015 Bersearch Information Services. All rights reserved.
//

import Cocoa

/*

A draw document will support drawing of oval, rectangle and line objects. Line objects will maintain
a starting point, ending point and stroke color. All objects will maintain objectBounds

*/


class Line: DrawObject {
    
    var initialPoint: CGPoint
    var finalPoint: CGPoint
    
    init(objectBounds: CGRect, initialPoint: CGPoint, finalPoint: CGPoint, strokeColor:NSColor) {
        self.initialPoint = initialPoint
        self.finalPoint = finalPoint
        super.init(objectBounds: objectBounds, strokeColor: strokeColor)
    }
    
    required init(coder aDecoder: NSCoder) {
        initialPoint = aDecoder.decodePointForKey("initialPoint")
        finalPoint = aDecoder.decodePointForKey("finalPoint")
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodePoint(initialPoint, forKey: "initialPoint")
        aCoder.encodePoint(finalPoint, forKey: "finalPoint")
        super.encodeWithCoder(aCoder)
    }
    
    
    override func draw() {
        let path = NSBezierPath()
        path.moveToPoint(initialPoint)
        path.lineToPoint(finalPoint)
        strokeColor.set()
        path.stroke()
    }


}
