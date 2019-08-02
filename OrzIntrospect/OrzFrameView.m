//
//  OrzFrameView.m
//
//  Created by Domestic Cat on 29/04/11.
//

#import "OrzFrameView.h"

typedef enum : NSUInteger {
    DrawLeft,
    DrawRight,
    DrawTop,
    DrawBottom
} DrawDirection;


@implementation OrzFrameView

-(UILabel *)touchPointLabel {
    if(!_touchPointLabel) {
        _touchPointLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _touchPointLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        _touchPointLabel.textAlignment = NSTextAlignmentCenter;
        _touchPointLabel.textColor = [UIColor whiteColor];
        _touchPointLabel.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.65f];
        _touchPointLabel.layer.cornerRadius = 5.5f;
        _touchPointLabel.layer.masksToBounds = YES;
        _touchPointLabel.alpha = 0.0f;
    }
    return _touchPointLabel;
}

-(OrzCrossHairView *)touchPointView {
    if(!_touchPointView) {
        _touchPointView = [[OrzCrossHairView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 17.0f, 17.0f) color:[UIColor blueColor]];
        _touchPointView.alpha = 0.0f;
    }
    return _touchPointView;
}

-(NSMutableArray *)rectsToOutline {
    if(!_rectsToOutline) {
        _rectsToOutline = [NSMutableArray array];
    }
    return _rectsToOutline;
}

#pragma mark - Setup

- (id)initWithFrame:(CGRect)frame delegate:(id)aDelegate
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = aDelegate;
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        // 显示当前光标所在坐标位置的标签，初始隐藏
        [self addSubview:self.touchPointLabel];
        
        // 显示当前光标的形状
        [self addSubview:self.touchPointView];
    }
    return self;
}

#pragma mark - Custom Setters

- (void)setMainRect:(CGRect)newMainRect
{
    _mainRect = newMainRect;
    [self setNeedsDisplay];
}

- (void)setSuperRect:(CGRect)newSuperRect
{
    _superRect = newSuperRect;
    [self setNeedsDisplay];
}

#pragma mark - Drawing/Display

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 如果要画矩形边框
    if (self.rectsToOutline.count > 0)
    {
        // 画出所有的矩形内边框
        for (NSValue *value in self.rectsToOutline)
        {
            UIColor *randomColor = [UIColor colorWithRed:(arc4random() % 256) / 256.0f
                                                   green:(arc4random() % 256) / 256.0f
                                                    blue:(arc4random() % 256) / 256.0f
                                                   alpha:1.0f];
            [randomColor set];
            CGRect valueRect = [value CGRectValue];
            // 内边框
            valueRect = CGRectMake(valueRect.origin.x + 0.5f,
                                   valueRect.origin.y + 0.5f,
                                   valueRect.size.width - 1.0f,
                                   valueRect.size.height - 1.0f);
            CGContextStrokeRect(context, valueRect);
        }
        
    }
    
    // 如果不画矩形边框
    else {
        // 如果视图没有尺寸就不绘制
        if (CGRectIsEmpty(self.mainRect)) {
            return;
        }
        
        BOOL showAntialiasingWarning = NO;
        
        if (!CGRectIsEmpty(self.superRect))
        {
            if(!CGRectEqualToRect(CGRectIntegral(self.mainRect), self.mainRect)) {
                showAntialiasingWarning = YES;
            }
        }
        
        if (showAntialiasingWarning)
        {
            [[UIColor redColor] set];
            
            NSLog(@"OrzIntrospect: *** WARNING: One or more values of this view's frame are non-integer values. This view will likely look blurry. ***");
        }
        else
        {
            [[UIColor blueColor] set];
        }
        
        // 画出选中的当前视图的内边框，如果是锯齿的用红色边框显示，否则用蓝色
        CGRect adjustedMainRect = CGRectMake(self.mainRect.origin.x + 0.5f,
                                             self.mainRect.origin.y + 0.5f,
                                             self.mainRect.size.width - 1.0f,
                                             self.mainRect.size.height - 1.0f);
        CGContextStrokeRect(context, adjustedMainRect);
        
        
        // 画左边的尺寸标线
        CGPoint start = CGPointMake(CGRectGetMinX(self.superRect),
                                    floorf(CGRectGetMidY(adjustedMainRect)) + 0.5f);
        CGPoint end = CGPointMake(CGRectGetMinX(adjustedMainRect), floorf(CGRectGetMidY(adjustedMainRect)) + 0.5f);
        [self drawDashLineInContext:context startPoint:start endPoint:end];

        // 画右边的尺寸标线
        start = CGPointMake(CGRectGetMaxX(adjustedMainRect), floorf(CGRectGetMidY(adjustedMainRect)) + 0.5f);
        end = CGPointMake(CGRectGetMaxX(self.superRect), floorf(CGRectGetMidY(adjustedMainRect)) + 0.5f);
        [self drawDashLineInContext:context startPoint:start endPoint:end];
        
        
        // 画上边的尺寸标线
        start = CGPointMake(floorf(CGRectGetMidX(adjustedMainRect)) + 0.5f, self.superRect.origin.y);
        end = CGPointMake(floorf(CGRectGetMidX(adjustedMainRect)) + 0.5f, CGRectGetMinY(adjustedMainRect));
        [self drawDashLineInContext:context startPoint:start endPoint:end];
        
        // 画下边的尺寸标线
        start = CGPointMake(floorf(CGRectGetMidX(adjustedMainRect)) + 0.5f, CGRectGetMaxY(adjustedMainRect));
        end = CGPointMake(floorf(CGRectGetMidX(adjustedMainRect)) + 0.5f, CGRectGetMaxY(self.superRect));
        [self drawDashLineInContext:context startPoint:start endPoint:end];

        
        // 添加左边距离标签
        CGFloat leftDistance = CGRectGetMinX(self.mainRect) - CGRectGetMinX(self.superRect);
        [self drawDistanceLabelWithDistance:leftDistance isAliasing:showAntialiasingWarning direction:DrawLeft];
        
        // 添加右边距离标签
        CGFloat rightDistance = CGRectGetMaxX(self.superRect) - CGRectGetMaxX(self.mainRect);
        [self drawDistanceLabelWithDistance:rightDistance isAliasing:showAntialiasingWarning direction:DrawRight];
        
        // 添加顶部距离标签
        CGFloat topDistance = CGRectGetMinY(self.mainRect) - CGRectGetMinY(self.superRect);
        [self drawDistanceLabelWithDistance:topDistance isAliasing:showAntialiasingWarning direction:DrawTop];
        
        // 添加底部距离标签
        CGFloat bottomDistance = CGRectGetMaxY(self.superRect) - CGRectGetMaxY(self.mainRect);
        [self drawDistanceLabelWithDistance:bottomDistance isAliasing:showAntialiasingWarning direction:DrawBottom];
    }
}

- (void)drawDashLineInContext:(CGContextRef)context startPoint:(CGPoint)start  endPoint:(CGPoint)end {
    
    CGFloat dash[] = {3.0, 3.0};
    CGContextSetLineDash(context, 0, dash, 2);
    
    CGContextMoveToPoint(context, start.x, start.y);
    CGContextAddLineToPoint(context, end.x, end.y);
    CGContextStrokePath(context);
}

- (void)drawDistanceLabelWithDistance: (CGFloat)distance isAliasing: (BOOL)isAlias direction:(DrawDirection)direction {
    
    // 距离标签文本格式化器
    NSString *formatter= (isAlias) ? @"%.1f": @"%.0f";
    UIFont *font = [UIFont systemFontOfSize:10.0f];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    NSString *distanceString = [NSString stringWithFormat: formatter, distance];
    CGSize size = [distanceString sizeWithAttributes:attributes];
    
    CGRect drawRect = CGRectZero;
    switch (direction){
        case DrawLeft:
        {
            drawRect = CGRectMake(CGRectGetMinX(self.superRect) + 1.0f,
                                  floorf(CGRectGetMidY(self.mainRect)) - size.height,
                                  size.width,
                                  size.height);
            
            break;
        }
        case DrawRight:
        {
            drawRect = CGRectMake(CGRectGetMaxX(self.superRect) - size.width - 1.0f,
                                  floorf(CGRectGetMidY(self.mainRect)) - 0.5f - size.height,
                                  size.width,
                                  size.height);
            
            break;
        }
        case DrawTop:
        {
            drawRect = CGRectMake(floorf(CGRectGetMidX(self.mainRect)) + 3.0f,
                                  floorf(CGRectGetMinY(self.superRect)),
                                  size.width,
                                  size.height);
            
            break;
        }
        case DrawBottom:
        {
            drawRect = CGRectMake(floorf(CGRectGetMidX(self.mainRect)) + 3.0f,
                                  floorf(CGRectGetMaxY(self.superRect)) - size.height - 1.0f,
                                  size.width,
                                  size.height);
            
            break;
        }
        default:
        {
            drawRect = CGRectZero;
            break;
        }
    }
    
    if(!CGRectEqualToRect(drawRect, CGRectZero)){
        [distanceString drawInRect: drawRect withAttributes:attributes];
    }
}

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat labelDistance = 16.0f;
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    // adjust the point so it's exactly on the point of the mouse cursor
    touchPoint.x -= 1;
    touchPoint.y -= 2;
    
    NSString *touchPontLabelString = [NSString stringWithFormat:@"%.0f, %.0f", touchPoint.x, touchPoint.y];
    self.touchPointLabel.text = touchPontLabelString;
    NSDictionary *attributes = @{NSFontAttributeName: self.touchPointLabel.font};
    CGSize stringSize = [touchPontLabelString sizeWithAttributes:attributes];
    CGRect frame = CGRectMake(touchPoint.x - floorf(stringSize.width / 2.0f) - 5.0f,
                              touchPoint.y - stringSize.height - labelDistance,
                              stringSize.width + 11.0f,
                              stringSize.height + 4.0f);
    
    // make sure the label stays inside the frame
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat minY = UIInterfaceOrientationIsPortrait(orientation) ? [UIApplication sharedApplication].statusBarFrame.size.height : [UIApplication sharedApplication].statusBarFrame.size.width;
    minY += 2.0f;		// to keep it touching the top bar
    if (frame.origin.x < 2.0f)
        frame.origin.x = 2.0f;
    else if (CGRectGetMaxX(frame) > self.bounds.size.width - 2.0f)
        frame.origin.x = self.bounds.size.width - frame.size.width - 2.0f;
    if (frame.origin.y < minY)
        frame.origin.y = touchPoint.y + stringSize.height + 4.0f;
    
    self.touchPointLabel.frame = frame;
    self.touchPointView.center = CGPointMake(touchPoint.x + 0.5f, touchPoint.y + 0.5f);
    self.touchPointView.alpha = self.touchPointLabel.alpha = 1.0f;
    
    [self.delegate touchAtPoint:touchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.08 animations:^{
        self.touchPointView.alpha = 0.0;
        self.touchPointLabel.alpha = 0.0f;
    }];
}

@end
