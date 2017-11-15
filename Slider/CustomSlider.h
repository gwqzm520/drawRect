//
//  CustomSlider.h
//  Slider
//
//  Created by shirly.zhu on 2017/9/6.
//  Copyright © 2017年 shirly.zhu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomSlider;

@protocol ZVScrollSliderDelegate <NSObject>

-(void)ZVScrollSlider:(CustomSlider *)slider ValueChange:(int )value;

@optional
-(void)ZVScrollSliderDidDelete:(CustomSlider *)slider;
-(void)ZVScrollSliderDidTouch:(CustomSlider *)slider;

@end

@interface CustomSlider : NSView

@property (nonatomic, copy ) NSString *title;
@property (nonatomic, copy ,  readonly) NSString *unit;
@property (nonatomic, assign ,readonly) int minValue;
@property (nonatomic, assign ,readonly) int maxValue;
@property (nonatomic, assign ,readonly) int step;
@property (nonatomic, weak) id<ZVScrollSliderDelegate> delegate;

@property (nonatomic, assign) float realValue;
-(void)setRealValue:(float)realValue Animated:(BOOL)animated;

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title MinValue:(int)minValue MaxValue:(int)maxValue Step:(int)step Unit:(NSString *)unit HasDeleteBtn:(BOOL)hasDeleteBtn;
+(CGFloat)heightWithBoundingWidth:(CGFloat )width Title:(NSString *)title;

@end
