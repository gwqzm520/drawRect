//
//  lineView.m
//  Slider
//
//  Created by shirly.zhu on 2017/9/5.
//  Copyright © 2017年 shirly.zhu. All rights reserved.
//

#import "lineView.h"

@implementation lineView

-(BOOL)isFlipped
{
    return YES;
}

//DM8000，画矩形网格
- (void)draw_Background:(NSRect)rClipRect ref:(CGContextRef)pRef showGrid:(BOOL)showGrid
{
    if (showGrid) {
        CGContextSetRGBFillColor(pRef, 255/255.0, 255/255.0, 0/255.0, 1) ;
        CGContextFillRect(pRef, rClipRect) ;
        //background grid...
        CGContextSetRGBStrokeColor(pRef, 43/255.0, 43/255.0, 43/255.0, 1) ;
        CGContextSetLineWidth(pRef, 1.0) ;
        int  i, step = 10 ;//50,75,100,125,150,175,200   4,5,8,10,14,18,20
        int  x0 = rClipRect.origin.x ;
        int  y0 = rClipRect.origin.y ;
        int  x1 = rClipRect.origin.x + rClipRect.size.width ;
        int  y1 = rClipRect.origin.y + rClipRect.size.height ;
        for (i=0;i<NSMaxY(self.bounds);i+=step)  { //horizontal line
            if (i < y0 || i > y1)  continue ;
            CGContextMoveToPoint(pRef, x0, i) ;
            CGContextAddLineToPoint(pRef, x1, i) ;
        }
        for (i=0;i<NSMaxX(self.bounds);i+=step)  { //vertical line
            if (i < x0 || i > x1)  continue ;
            CGContextMoveToPoint(pRef, i, y0) ;
            CGContextAddLineToPoint(pRef, i, y1) ;
        }
        CGContextStrokePath(pRef) ;
    }
}

//画矩形网格
-(void)drawGridInContext:(CGContextRef)context rect:(NSRect)dirtyRect showGrid:(BOOL)showGrid
{
    if (showGrid) {
        [[NSColor redColor] setStroke];
        CGContextSetLineWidth(context, 1);
        
        CGFloat span = 10.0f;
        CGFloat startX = 0;//roundf(dirtyRect.origin.x / span);
        CGFloat endX = NSMaxX(self.bounds);
        CGFloat startY = 0;//roundf(dirtyRect.origin.y / span);
        CGFloat endY = NSMaxY(self.bounds);
        
        while (startX <= endX)
        {
            CGContextMoveToPoint(context, startX, dirtyRect.origin.y);
            CGContextAddLineToPoint(context, startX, dirtyRect.origin.y + dirtyRect.size.height);
            CGContextStrokePath(context);
            startX += span;
        }
        
        while (startY <= endY)
        {
            CGContextMoveToPoint(context, dirtyRect.origin.x, startY);
            CGContextAddLineToPoint(context, dirtyRect.origin.x + dirtyRect.size.width, startY);
            CGContextStrokePath(context);
            startY += span;
        }
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    CGContextRef ref = [[NSGraphicsContext currentContext] graphicsPort];
//    [self drawGridInContext:ref rect:dirtyRect showGrid:YES];
    [self draw_Background:dirtyRect ref:ref showGrid:YES];
}

@end
