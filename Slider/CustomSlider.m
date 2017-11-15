//
//  CustomSlider.m
//  Slider
//
//  Created by shirly.zhu on 2017/9/6.
//  Copyright © 2017年 shirly.zhu. All rights reserved.
//

#import "CustomSlider.h"
#define dialColorGrayscale 0.789 //刻度的颜色灰度
#define textColorGrayscale 0.629 //文字的颜色灰度
#define textRulerFont [NSFont systemFontOfSize:9]

#define dialGap 6
#define dialLong 18
#define dialShort 9


#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface ZVRulerView : NSView
@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int maxValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation ZVRulerView

/**
 *  绘制标尺view
 *
 *  @param rect rect
 */
-(void)drawRect:(CGRect)rect
{
    //计算位置
    CGFloat startX = 0;
    
    CGFloat lineCenterX = dialGap;
    CGFloat shortLineY = rect.size.height - dialShort;
    CGFloat longLineY = rect.size.height - dialLong;
    CGFloat bottomY = rect.size.height;
    
    if (_maxValue == 0)
    {
        _maxValue = 1000;
    }
    CGFloat step = (_maxValue-_minValue)/10;
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    CGContextSetStrokeColorWithColor(context, [NSColor darkGrayColor].CGColor);
    //CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    CGContextSetLineWidth(context, 0.5);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    for (int i = 0; i<=10; i++)
    {
        if (i%10 == 0)
        {
            CGContextMoveToPoint(context,startX + lineCenterX*i, longLineY);//起使点
            NSString *Num = [NSString stringWithFormat:@"%.f%@",i*step+_minValue,_unit];
            if ([Num floatValue]>1000000)
            {
                Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/10000.f,_unit];
            }
            
            NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[NSColor colorWithWhite:textColorGrayscale alpha:1]};
            CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
            [Num drawInRect:CGRectMake(startX + lineCenterX*i-width/2, longLineY-14, width, 14) withAttributes:attribute];
        }
        else
        {
            CGContextMoveToPoint(context,startX +  lineCenterX*i, shortLineY);//起使点
        }
        CGContextAddLineToPoint(context,startX +  lineCenterX*i, bottomY);
        CGContextStrokePath(context);//开始绘制
    }
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface ZVFooterRulerView : NSView
@property (nonatomic, assign) int maxValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation ZVFooterRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    //        CGContextSetLineWidth(context, 2.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextMoveToPoint(context,0, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%d%@",_maxValue,_unit];
    if ([Num floatValue]>1000000)
    {
        Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/10000.f,_unit];
    }
    
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[NSColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(0-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,0, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------
@interface ZVHeaderRulerView : NSView
@property (nonatomic, assign) int minValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation ZVHeaderRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    //        CGContextSetLineWidth(context, 2.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextMoveToPoint(context,rect.size.width, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%d%@",_minValue,_unit];
    if ([Num floatValue]>1000000)
    {
        Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/10000.f,_unit];
    }
    
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[NSColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(rect.size.width-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,rect.size.width, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

@interface CustomSlider ()<NSTextFieldDelegate,NSCollectionViewDelegate,NSCollectionViewDataSource,NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSButton         *deleteBtn;
@property (nonatomic, strong) NSTextField          *titleLabel;
@property (nonatomic, strong) NSTextField      *valueTF;
@property (nonatomic, strong) NSCollectionView *collectionView;
@property (nonatomic, strong) NSImageView      *redLine;
@property (nonatomic, strong) NSImageView      *bottomLine;

@property (nonatomic, assign) int              stepNum;
@property (nonatomic, assign) int              value;
@property (nonatomic, assign) BOOL             scrollByHand;

@end

@implementation CustomSlider

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title MinValue:(int)minValue MaxValue:(int)maxValue Step:(int)step Unit:(NSString *)unit HasDeleteBtn:(BOOL)hasDeleteBtn
{
    if(self = [super initWithFrame:frame])
    {
        //readOnly设置
        _title = title;
        _minValue = minValue;
        _maxValue = maxValue;
        _step = step;
        _stepNum = (_maxValue-_minValue)/_step/10;
        _unit = unit;
        _scrollByHand = NO;
        
        //删除按钮
        
        _deleteBtn = [[NSButton alloc]initWithFrame:CGRectMake(10, 40, 18, 18)];
//        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
//        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateHighlighted];
//        [_deleteBtn setBackgroundColor:[NSColor lightGrayColor]];
//        _deleteBtn.titleLabel.font = [NSFont systemFontOfSize:18];
        _deleteBtn.layer.cornerRadius = 9;
        _deleteBtn.layer.masksToBounds = YES;
//        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
//        if (hasDeleteBtn)
//        {
//            [self addSubview:_deleteBtn];
//        }
        
        //名称Label
        CGFloat height            = [_title boundingRectWithSize:CGSizeMake(frame.size.width-10-18-6-15, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[NSFont systemFontOfSize:14]} context:nil].size.height;
        _titleLabel               = [[NSTextField alloc]initWithFrame:CGRectMake(10+18+6, 40, frame.size.width-10-18-6-15, height)];
        if (!hasDeleteBtn)
        {
            _titleLabel.frame = CGRectMake(15, 40, frame.size.width-30, height);
        }
        _titleLabel.wantsLayer = YES;
        _titleLabel.font          = [NSFont systemFontOfSize:14];
        _titleLabel.maximumNumberOfLines = 0;
        _titleLabel.alignment = NSTextAlignmentCenter;
        _titleLabel.stringValue          = _title;
        _titleLabel.textColor     = [NSColor blackColor];
        [self addSubview:_titleLabel];
        
        //输入框
        _valueTF                          = [[NSTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+10, frame.size.width, 20)];
        
//        _valueTF.defaultTextAttributes    = @{NSUnderlineColorAttributeName:[NSColor orangeColor],
//                                              NSUnderlineStyleAttributeName:@(1),
//                                              NSFontAttributeName:[NSFont systemFontOfSize:18],
//                                              NSForegroundColorAttributeName:[NSColor orangeColor]};
        _valueTF.alignment            = NSTextAlignmentCenter;
        _valueTF.delegate                 = self;
//        _valueTF.keyboardType             = UIKeyboardTypeNumberPad;
        _valueTF.placeholderString = @"滑动标尺或输入";
//        _valueTF.attributedPlaceholder    = [[NSAttributedString alloc]initWithString:@"滑动标尺或输入"
//                                                                           attributes:@{NSUnderlineColorAttributeName:[NSColor lightGrayColor],
//                                                                                        NSUnderlineStyleAttributeName:@(1),
//                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:12],
//                                                                                        NSForegroundColorAttributeName:[UIColor grayColor]}];
        [self addSubview:_valueTF];
        
        //标尺
        
        NSCollectionViewFlowLayout *flowLayout =[[NSCollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:NSCollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:NSEdgeInsetsMake(0, 0, 0, 0)];
        
        _collectionView = [[NSCollectionView alloc] initWithFrame:NSMakeRect(0, 0, self.bounds.size.width, 50)];
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor whiteColor].CGColor;
        _collectionView.layer.backgroundColor = [NSColor redColor].CGColor;
        
        [_collectionView registerClass:[NSCollectionView class] forItemWithIdentifier:@"systemCell"];
        
          [_collectionView registerClass:[NSCollectionView class] forItemWithIdentifier:@"custemCell"];
     
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        _redLine = [[NSImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-0.5, CGRectGetMaxY(_valueTF.frame)+5, 1, 45)];
        _redLine.wantsLayer = YES;
        _redLine.layer.backgroundColor = [NSColor orangeColor].CGColor;
        [self addSubview:_redLine];
        
        _bottomLine = [[NSImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width, 0.5)];
        _redLine.layer.backgroundColor = [NSColor grayColor].CGColor;
        [self addSubview:_bottomLine];
    }
    return self;
}

+(CGFloat)heightWithBoundingWidth:(CGFloat )width Title:(NSString *)title
{
    CGFloat height  = [title boundingRectWithSize:CGSizeMake(width-10-18-6-15, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:[NSFont systemFontOfSize:14]}
                                          context:nil].size.height;
    return 40+height+10+20+50;
}

#pragma setter
-(void)setRealValue:(float)realValue
{
    [self setRealValue:realValue Animated:NO];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.stringValue     = _title;
}

-(void)setRealValue:(float)realValue Animated:(BOOL)animated
{
    _realValue = realValue;
    _valueTF.stringValue = [NSString stringWithFormat:@"%d",(int)(_realValue*_step)];
//    [_collectionView setContentOffset:CGPointMake((int)realValue*dialGap, 0) animated:animated];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZVScrollSlider:ValueChange:)])
    {
        [self.delegate ZVScrollSlider:self ValueChange:realValue*_step];
    }
}

#pragma UITextFieldDelegate
-(BOOL)textField:(NSTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newStr = [textField.stringValue stringByReplacingCharactersInRange:range withString:string];
    if ([newStr intValue] > _maxValue)
    {
        _valueTF.stringValue = [NSString stringWithFormat:@"%d",_maxValue];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:0];
        return NO;
    }
    else
    {
        _scrollByHand = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:1];
        return YES;
    }
}

-(void)didChangeValue
{
    [self setRealValue:[_valueTF.stringValue floatValue]/(float)_step Animated:YES];
}

-(void)deleteAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZVScrollSliderDidDelete:)])
    {
        [self.delegate ZVScrollSliderDidDelete:self];
    }
}

#pragma mark UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2+_stepNum;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_MAC(10_11)
{
    if (indexPath.item == 0 || indexPath.item == _stepNum+1)
    {
        NSCollectionViewItem *cell = [collectionView makeItemWithIdentifier:@"systemCell" forIndexPath:indexPath];
       
        NSView *halfView = [cell.collectionView viewWithTag:9527];
        if (!halfView)
        {
            if (indexPath.item == 0)
            {
                halfView = [[ZVHeaderRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 50)];
                ZVHeaderRulerView *header = (ZVHeaderRulerView *)halfView;
                header.wantsLayer = YES;
                header.layer.backgroundColor = [NSColor whiteColor].CGColor;
                header.minValue = _minValue;
                header.unit = _unit;
                [cell.collectionView addSubview:header];
            }
            else
            {
                halfView = [[ZVFooterRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 50)];
                ZVFooterRulerView *footer = (ZVFooterRulerView *)halfView;
                footer.wantsLayer = YES;
                footer.layer.backgroundColor = [NSColor whiteColor].CGColor;
                footer.maxValue = _maxValue;
                footer.unit = _unit;
                [cell.collectionView addSubview:footer];
            }
        }
        
        return cell;
    }
    else
    {
         NSCollectionViewItem *cell = [collectionView makeItemWithIdentifier:@"custemCell" forIndexPath:indexPath];

        ZVRulerView *ruleView = [cell.collectionView viewWithTag:9527];
        if (!ruleView)
        {
            ruleView                 = [[ZVRulerView alloc]initWithFrame:CGRectMake(0, 0, dialGap*10, 50)];
            ruleView.layer.backgroundColor = [NSColor whiteColor].CGColor;
//            ruleView.tag             = 9527;
            ruleView.unit            = _unit;
            [cell.collectionView addSubview:ruleView];
        }
        ruleView.minValue = _step*10.f*(indexPath.item-1);
        ruleView.maxValue = _step*10.f*indexPath.item;
//        [ruleView setNeedsDisplay];
        
        return cell;
    }
}
-(CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == _stepNum+1)
    {
        return CGSizeMake(self.frame.size.width/2, 50.f);
    }
    else
    {
        return CGSizeMake(dialGap*10.f, 50.f);
    }

}

-(NSEdgeInsets)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return NSEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(CGFloat)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
     return 0.f;
}

-(void)touchesBegan:(NSSet<NSTouch *> *)touches withEvent:(NSEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (point.y < self.frame.size.height-50-20)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ZVScrollSliderDidTouch:)])
        {
            [self.delegate ZVScrollSliderDidTouch:self];
        }
    }
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(NSScrollView *)scrollView
{
    if (_scrollByHand)
    {
        int value = 5.0/(dialGap);
        _valueTF.stringValue = [NSString stringWithFormat:@"%d",value*_step];
    }
}

-(void)scrollViewWillBeginDragging:(NSScrollView *)scrollView
{
    _scrollByHand = YES;
}

-(void)scrollViewDidEndDragging:(NSScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)//拖拽时没有滑动动画
    {
        [self setRealValue:round(5.0/(dialGap)) Animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(NSScrollView *)scrollView
{
    [self setRealValue:round(5.0/(dialGap)) Animated:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
