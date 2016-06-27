//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Created by Daniel Cohen Gindi on 19/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation
import UIKit;
import Charts;

public class BalloonMarker: ChartMarker
{
    public var color: UIColor?
    public var arrowSize = CGSize(width: 15, height: 11)
    public var font: UIFont?
    public var insets = UIEdgeInsets()
    public var minimumSize = CGSize()
    public var barDescription = NSMutableArray()
    public var lineDateDescription = NSMutableArray()
    
    private var labelns: NSString?
    private var _labelSize: CGSize = CGSize()
    private var _size: CGSize = CGSize()
    private var _paragraphStyle: NSMutableParagraphStyle?
    private var _drawAttributes = [String : AnyObject]()
    
    public init(color: UIColor, font: UIFont, insets: UIEdgeInsets)
    {
        super.init()
        
        self.color = color
        self.font = font
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .Center
    }
    
    public override var size: CGSize { return _size; }
    
    public override func draw(context context: CGContext, point: CGPoint)
    {
        if (labelns == nil)
        {
            return
        }
        
        var rect = CGRect(origin: point, size: _size)
        rect.origin.x -= _size.width / 2.0
        rect.origin.y -= _size.height
        
        let maxXpiex = rect.origin.x + rect.size.width
        let APP_Width = UIScreen .mainScreen().bounds.size.width
        var newXpiex = rect.origin.x
        
        if maxXpiex > APP_Width {
            newXpiex = APP_Width - rect.size.width;
        }
        
        CGContextSaveGState(context)
        
        CGContextSetFillColorWithColor(context, color?.CGColor)
        CGContextBeginPath(context)
        //left up
        CGContextMoveToPoint(context,
                             newXpiex,
                             rect.origin.y)
        //right up
        CGContextAddLineToPoint(context,
                                newXpiex + rect.size.width,
                                rect.origin.y)
        //right down
        CGContextAddLineToPoint(context,
                                newXpiex + rect.size.width,
                                rect.origin.y + rect.size.height - arrowSize.height)
        //center point right
        CGContextAddLineToPoint(context,
                                rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                                rect.origin.y + rect.size.height - arrowSize.height)
        //center point
        CGContextAddLineToPoint(context,
                                rect.origin.x + rect.size.width / 2.0,
                                rect.origin.y + rect.size.height)
        //center point left
        CGContextAddLineToPoint(context,
                                rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                                rect.origin.y + rect.size.height - arrowSize.height)
        //left down
        CGContextAddLineToPoint(context,
                                newXpiex,
                                rect.origin.y + rect.size.height - arrowSize.height)
        //left up
        CGContextAddLineToPoint(context,
                                newXpiex,
                                rect.origin.y)
        CGContextFillPath(context)
        
        rect.origin.y += self.insets.top
        
        if maxXpiex > APP_Width {
            rect.origin.x = newXpiex
        }
        
        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        labelns?.drawInRect(rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        CGContextRestoreGState(context)
    }
    
    public override func refreshContent(entry entry: ChartDataEntry, highlight: ChartHighlight)
    {
        let isGroup = highlight.dataSetIndex
        print(isGroup)
        let xIndex = highlight.xIndex
        let detailDes: [NSString]
        var text: NSString = ""
        var childAry: [NSString]
        
        if self.barDescription.count > 0 {
            
            childAry = self.barDescription[0] as! [NSString]
            
            if childAry.count > xIndex {
                detailDes = self.barDescription[isGroup] as! [NSString]
                text = detailDes[xIndex]
            }
        }
        
        if(self.lineDateDescription.count > 0){
            text = lineDateDescription[xIndex] as! NSString
            text =  (text as String) + "\n"
        }
        
        let label = (text as String) + entry.value.description
        labelns = label as NSString
        
        _drawAttributes.removeAll()
        _drawAttributes[NSFontAttributeName] = self.font
        _drawAttributes[NSParagraphStyleAttributeName] = _paragraphStyle
        
        _labelSize = labelns?.sizeWithAttributes(_drawAttributes) ?? CGSizeZero
        _size.width = _labelSize.width + self.insets.left + self.insets.right
        _size.height = _labelSize.height + self.insets.top + self.insets.bottom
        if(self.lineDateDescription.count > 0){
            _size.height += 6
        }
        _size.width = max(minimumSize.width, _size.width)
        _size.height = max(minimumSize.height, _size.height)
    }
}