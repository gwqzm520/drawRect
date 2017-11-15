//
//  ViewController.m
//  Slider
//
//  Created by shirly.zhu on 2017/8/29.
//  Copyright © 2017年 shirly.zhu. All rights reserved.
//

#import "ViewController.h"
#define  TEST_VIEW_WIDTH         6400
#define  TEST_VIEW_HEIGHT        5120

#import "lineView.h"
#import "CustomSlider.h"

@implementation ViewController
{
    lineView *line;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *title = @"投资";
    
//    CGFloat sliderHeight = [CustomSlider heightWithBoundingWidth:self.view.bounds.size.width Title:title];
//    CustomSlider *productSlider  = [[CustomSlider alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, sliderHeight)
//                                                                    Title:title
//                                                                 MinValue:0
//                                                                 MaxValue:10000000
//                                                                     Step:1000
//                                                                     Unit:@""
//                                                             HasDeleteBtn:NO];
//    [self.view addSubview:productSlider];

    line = [[lineView alloc] initWithFrame:NSMakeRect(5, 5, 500, 100)];
    line.wantsLayer = YES;
    line.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    [self.view addSubview:line];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)clickCheck:(id)sender
{
    if (_checkBtn.state==0) {
        [line removeFromSuperview];
    }
    else
    {
        [self.view addSubview:line];
    }
}
@end
