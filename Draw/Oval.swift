//
//  Oval.swift
//  Draw
//
//  Created by Tom Bernard on 10/18/15.
//  Copyright (c) 2015 Bersearch Information Services. All rights reserved.
//

import Cocoa

/*

A draw document will support drawing of oval, rectangle and line objects. Oval and Rectangle objects will
maintain a stroke color and a fill color. All objects will maintain objectBounds

*/


class Oval: DrawObject {
    
    var fillColor: NSColor = NSColor.clearColor()
    
    init(objectBounds: CGRect, strokeColor:NSColor, fillColor: NSColor) {
        super.init(objectBounds: objectBounds, strokeColor: strokeColor)
        self.fillColor = fillColor
    }
    
    
    override func draw() {
        let path = NSBezierPath(ovalInRect: objectBounds)
        fillColor.set()
        path.fill()
        strokeColor.set()
        path.stroke()
    }

}
