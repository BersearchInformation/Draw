//
//  ToolbarView.swift
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

A draw document will present a drawing view and a toolbar view (eventually, the toolbar view will move to a
supporting panel instead of being instantiated within each document window).

*/


class ToolbarView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
