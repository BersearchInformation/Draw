//
//  ToolbarView.swift
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
maintain a stroke color and a fill color. Line objects will maintain a stroke color. All objects will maintain
objectBounds

A draw document will present a drawing view and a toolbar view (eventually, the toolbar view will move to a
supporting panel instead of being instantiated within each document window).

*/

enum ToolSelectedType {
    case OvalTool
    case RectangleTool
    case LineTool
}


class ToolbarView: NSView {
    
    @IBOutlet weak var ovalButton: NSButton!
    @IBOutlet weak var rectangleButton: NSButton!
    @IBOutlet weak var lineButton: NSButton!
    
    @IBOutlet weak var fillColorCW: NSColorWell!
    @IBOutlet weak var strokeColorCW: NSColorWell!
    
    
    var selectedTool: ToolSelectedType = ToolSelectedType.OvalTool {
        didSet {
//            if selectedTool == .OvalTool {
//                println("toolSelected = OvalTool")
//            }
//            if selectedTool == .RectangleTool {
//                println("toolSelected = RectangleTool")
//            }
//            if selectedTool == .LineTool {
//                println("toolSelected = LineTool")
//            }
        }
    }
    
    // used when implementing undo
    var toolName = "Oval"
    
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 54.0, height: 267.0)
    }
    

    
    override func drawRect(dirtyRect: NSRect) {
        NSColor(calibratedRed: 0.7, green: 0.8, blue: 1.0, alpha: 1.0).set()        // sky blue
        NSBezierPath.fillRect(self.bounds)
    }
    
    
    @IBAction func userSelectedTool(sender: NSButton) {
        switch (sender) {
        case ovalButton:
            selectedTool = .OvalTool
            toolName = "Oval"
            ovalButton.state =          NSOnState
            rectangleButton.state =     NSOffState
            lineButton.state =          NSOffState
        case rectangleButton:
            selectedTool = .RectangleTool
            toolName = "Rectangle"
            rectangleButton.state =     NSOnState
            ovalButton.state =          NSOffState
            lineButton.state =          NSOffState
        case lineButton:
            selectedTool = .LineTool
            toolName = "Line"
            lineButton.state =          NSOnState
            ovalButton.state =          NSOffState
            rectangleButton.state =     NSOffState
        default:
            selectedTool = .OvalTool
            toolName = "Oval"
            ovalButton.state =          NSOnState
            rectangleButton.state =     NSOffState
            lineButton.state =          NSOffState
        }
    }
}
