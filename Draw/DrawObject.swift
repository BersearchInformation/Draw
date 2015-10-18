//
//  DrawObject.swift
//  Draw
//
//  Created by Tom Bernard on 10/18/15.
//  Copyright (c) 2015 Bersearch Information Services. All rights reserved.
//

import Cocoa

/*

A draw document will support drawing of oval, rectangle and line objects. Oval and Rectangle objects will
maintain a stroke color and a fill color. Line objects will maintain a stroke color. All objects will maintain
objectBounds

*/

class DrawObject: NSObject {
    var objectBounds: CGRect = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    
    var strokeColor: NSColor = NSColor.clearColor()
    
    var fillColor: NSColor = NSColor.clearColor()
    
    func draw() {
        // subclasses will override draw() to implement their drawing behaviour
    }
}