//
//  ViewController.h
//  Slider
//
//  Created by shirly.zhu on 2017/8/29.
//  Copyright © 2017年 shirly.zhu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
{
    int                nBmpWi, nBmpHi ;
    char              *pBmpBuf ;
}
- (IBAction)clickCheck:(id)sender;
@property (weak) IBOutlet NSButton *checkBtn;

@end

