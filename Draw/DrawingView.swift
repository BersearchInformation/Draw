//
//  DrawingView.swift
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

A draw document will present a drawing view and a toolbar view (eventually, the toolbar view will move to a
supporting panel instead of being instantiated within each document window).

*/


class DrawingView: NSView {
    
    @IBOutlet weak var document: DrawDocument!
    
    var proposedObject: DrawObject? =       nil {
        didSet {
            needsDisplay = true
        }
    }
    
    var selectedTool: ToolSelectedType =    .OvalTool
    var fillColor: NSColor =                NSColor.clearColor()
    var strokeColor: NSColor =              NSColor.clearColor()
    
    var initialPoint: CGPoint =             CGPoint()
    
    

    override func drawRect(dirtyRect: NSRect) {
        NSColor.whiteColor().set()
        NSBezierPath.fillRect(self.bounds)
        
        for drawObject in document.drawObjects {
            drawObject.draw()
        }
        
        if let proposedObject = proposedObject {
            proposedObject.draw()
        }
    }
    
    
    // MARK: - mouse events
    
    /*
    
    mouseDown(theEvent: NSEvent)
    
    + query toolbar view for the selected tool, fill color and stroke color
    + set the proposed object's initial point
    (we get the tool and color info here in case the user clicks without dragging)
    
    
    mouseDragged(theEvent: NSEvent)
    
    draw representation of proposed object with alpha set to 0.5 * actual alpha
    
    + get the current point
    + compute colors
    + get the object bounds
    + create the proposed object
    
    
    mouseUp(theEvent: NSEvent)
    
    + discard the proposed object
    + get the final point
    + get the object's bounds
    + instantiate actual object and add it to object array
    
    */
    
    
    override func mouseDown(theEvent: NSEvent) {
        // get the selected tool
        selectedTool = document.toolbarView.selectedTool
        
        // get the fill color
        fillColor = document.toolbarView.fillColorCW.color
        
        // get the stroke color
        strokeColor = document.toolbarView.strokeColorCW.color
        
        // set the initial corner
        let locationInWindow = theEvent.locationInWindow
        initialPoint = convertPoint(locationInWindow, fromView: nil)
    }
    
    
    override func mouseDragged(theEvent: NSEvent) {
        // get the current point
        let locationInWindow = theEvent.locationInWindow
        let currentPoint = convertPoint(locationInWindow, fromView: nil)
        
        // compute the colors for the proposed object
        let proposedFillColor = proposedColorForColor(fillColor)
        let proposedStrokeColor = proposedColorForColor(strokeColor)
        
        // get the object bopunds
        let objectBounds = rectFromTwoPoints(initialPoint, currentPoint: currentPoint)
        
        // create the object
        switch selectedTool {
        case .OvalTool:
            proposedObject = Oval(
                objectBounds: objectBounds,
                strokeColor: proposedStrokeColor,
                fillColor: proposedFillColor)
        case .RectangleTool:
            proposedObject = Rectangle(
                objectBounds: objectBounds,
                strokeColor: proposedStrokeColor,
                fillColor: proposedFillColor)
        case .LineTool:
            proposedObject = Line(
                objectBounds: objectBounds,
                initialPoint: initialPoint,
                finalPoint: currentPoint,
                strokeColor: proposedStrokeColor)
        }
    }
    
    
    override func mouseUp(theEvent: NSEvent) {
        proposedObject = nil
        
        // get the final point
        let locationInWindow = theEvent.locationInWindow
        let finalPoint = convertPoint(locationInWindow, fromView: nil)
        
        // get the object bopunds
        let objectBounds = rectFromTwoPoints(initialPoint, currentPoint: finalPoint)

        // create the object
        var drawObject: DrawObject
        switch selectedTool {
        case .OvalTool:
            drawObject = Oval(
                objectBounds: objectBounds,
                strokeColor: strokeColor,
                fillColor: fillColor)
        case .RectangleTool:
            drawObject = Rectangle(
                objectBounds: objectBounds,
                strokeColor: strokeColor,
                fillColor: fillColor)
        case .LineTool:
            drawObject = Line(
                objectBounds: objectBounds,
                initialPoint: initialPoint,
                finalPoint: finalPoint,
                strokeColor: strokeColor)
        }
        
        // add it to the model array
        document.insertObject(drawObject, atIndex: document.drawObjects.count)
    }
    
    
    
    // MARK: - helpers
    
    func rectFromTwoPoints(initialPoint: CGPoint, currentPoint: CGPoint) -> CGRect {
        let x = initialPoint.x < currentPoint.x ? initialPoint.x : currentPoint.x
        let y = initialPoint.y < currentPoint.y ? initialPoint.y : currentPoint.y
        let width = initialPoint.x < currentPoint.x ? currentPoint.x - initialPoint.x : initialPoint.x - currentPoint.x
        let height = initialPoint.y < currentPoint.y ? currentPoint.y - initialPoint.y : initialPoint.y - currentPoint.y
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    /*
    
    proposedColorForColor(color: NSColor) -> NSColor 
    
    returns a color appropriate for drawing proposed objects
    
    */
    
    func proposedColorForColor(color: NSColor) -> NSColor {
        var proposedColor: NSColor
        
        // color is in an unknown colorspace - attempting to extract RGBA components could raise an exception
        // does color map to RGBA colorspace?
        let colorSpace = NSColorSpace.genericRGBColorSpace
        if let rgbaColor = color.colorUsingColorSpace(colorSpace())
        {
            let proposedColorAlpha = 0.5 * rgbaColor.alphaComponent
            proposedColor = NSColor(
                calibratedRed: rgbaColor.redComponent,
                green: rgbaColor.greenComponent,
                blue: rgbaColor.blueComponent,
                alpha: proposedColorAlpha)
        }
        else
        {
            // could not convert color to rgba colorspace - provide a light gray with 0.5 alpha as an alternate color
            proposedColor = NSColor(
                calibratedRed: 0.8,
                green: 0.8,
                blue: 0.8,
                alpha: 0.5)
        }
        return proposedColor
    }
}
