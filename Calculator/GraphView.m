//
//  GraphView.m
//  Calculator
//
//  Created by Dana Cleveland on 7/24/12.
//  Copyright (c) 2012 Scritch.org. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"

@implementation GraphView

@synthesize dataSource = _dataSource;
@synthesize scale = _scale;
@synthesize origin = _origin;

#define DEFAULT_SCALE 10.0

- (CGFloat)scale
{
    if (!_scale) {
        return DEFAULT_SCALE; // don't allow zero scale
    } else {
        return _scale;
    }
}
- (void)setScale:(CGFloat)scale
{
    if (scale != _scale) {
        _scale = scale;
        [self setNeedsDisplay]; // any time our scale changes, call for redraw
    }
}

- (CGPoint)origin
{
    if (!_origin.x) {
        _origin.x = self.bounds.origin.x + self.bounds.size.width/2;
    }
    if (!_origin.y) {
            _origin.y = self.bounds.origin.y + self.bounds.size.height/2;
    }
    return _origin;
}
- (void)setOrigin:(CGPoint)origin
{
    if ((origin.x != _origin.x) || (origin.y != _origin.y)) {
        _origin = origin;
        [self setNeedsDisplay]; // any time our origin changes, call for redraw
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale; // adjust our scale
        gesture.scale = 1;           // reset gestures scale to 1 (so future changes are incremental, not cumulative)
    }
}
- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self];
        CGPoint newOrigin = CGPointMake(self.origin.x + translation.x,self.origin.y +translation.y);
        self.origin = newOrigin;
        [gesture setTranslation:CGPointZero inView:self];
    }
}
 
- (void)triple:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.origin = [gesture locationInView:self];
    }

}
- (void)setup
{
    self.contentMode = UIViewContentModeRedraw; // if our bounds changes, redraw ourselves
}

- (void)awakeFromNib
{
    [self setup]; // get initialized when we come out of a storyboard
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)drawProgram:(CGContextRef) context   area:(CGRect)rect
{
    UIGraphicsPushContext(context);
    
    CGFloat startX = rect.origin.x;
    CGFloat endX = (rect.origin.x + rect.size.width);
    
    //NSLog([NSString stringWithFormat:@"start = %g   end = %g"],startX,endX);
    
    //CGContextBeginPath(context);
    [[UIColor greenColor] setStroke];
    
    
    CGFloat newValue = 1/self.contentScaleFactor;
    //go through each x pixel and calc y 
    for (CGFloat currentXPos = startX; currentXPos <= endX; currentXPos = currentXPos+newValue) {
        
        double xValue = (currentXPos - self.origin.x)/self.scale;
     
        double yValue = [self.dataSource graphView:self yValueForGraphView:xValue];
        
        //convert returned Y value back to points
        CGFloat yPos = self.origin.y - (yValue * self.scale);
        
        if (currentXPos != startX) { 
            CGContextAddLineToPoint(context, currentXPos, yPos);
        } else {
            CGContextMoveToPoint(context, currentXPos,yPos);
        }

        
    }
    CGContextStrokePath(context);                            
    //UIGraphicsPopContext();
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [AxesDrawer drawAxesInRect:rect originAtPoint:self.origin scale:self.scale];

    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIGraphicsPushContext(context);
        
    // draw the program
    [self drawProgram:context area:rect];
    
    UIGraphicsPopContext();

}

 
@end
