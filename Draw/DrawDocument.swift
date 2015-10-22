//
//  DrawDocument.swift
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

class DrawDocument: NSDocument {
    
    @IBOutlet weak var drawingView: DrawingView!
    @IBOutlet weak var toolbarView: ToolbarView!
    
    // model object
    var drawObjects: [DrawObject] = []          // initializes drawObjects to empty array
    

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        
        // Thank you Ken Ferry
        // http://www.cocoabuilder.com/archive/cocoa/208918-nscolorwell-and-alpha.html
        
        // tell the shared color panel to show alpha (default is to not show alpha)
        NSColorPanel.sharedColorPanel().showsAlpha = true
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        return "DrawDocument"
    }

    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        return NSKeyedArchiver.archivedDataWithRootObject(drawObjects)
    }

    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        let drawObjects = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [DrawObject]
        self.drawObjects = drawObjects
        return true
    }


}

