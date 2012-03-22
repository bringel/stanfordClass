//
//  GraphView.m
//  Calculator
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "CalculatorBrain.h"

@interface GraphView()

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat scale;

@end

@implementation GraphView

@synthesize origin = _origin;
@synthesize dataSource = _dataSource;
@synthesize scale = _scale;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setNeedsDisplay];
    }
    return self;
}

- (void)awakeFromNib{
    [self setOrigin:[self center]];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:3];
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGesture];
    UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self addGestureRecognizer:pinchGesture];
}

- (NSDictionary *)calculateValuesFromFunction:(NSString *)function{
    NSMutableDictionary * functionValues = [[NSMutableDictionary alloc] init];
    float width = self.bounds.size.width;
    for(int pixel = 0; pixel < width; pixel++){
        NSMutableDictionary * variables = [[NSMutableDictionary alloc] init];
        [variables setObject:[NSNumber numberWithInt:pixel] forKey:@"x"];
        double result = [CalculatorBrain runProgram:function usingVariableValues:variables];
        [functionValues setObject:[NSNumber numberWithDouble:result] forKey:[NSNumber numberWithInt:pixel]];
    }
    return functionValues;
}

#define DEFAULT_SCALE 10.0

- (void)drawRect:(CGRect)rect
{
    if(self.scale == 0)
        [AxesDrawer drawAxesInRect:[self bounds] originAtPoint:[self origin] scale:DEFAULT_SCALE];
    else 
        [AxesDrawer drawAxesInRect:[self bounds] originAtPoint:[self origin] scale:[self scale]];
   NSDictionary * xAndYValues = [self calculateValuesFromFunction:[self.dataSource setFunctionForGraphView]];   
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGFloat startX = (CGFloat)0;
    CGFloat startY = (CGFloat)[[xAndYValues objectForKey:[NSNumber numberWithInt:1]] intValue];
    CGContextMoveToPoint(context, startX, startY);
    for(int pixel = 1; pixel < self.bounds.size.width; pixel++){
        CGFloat x = (CGFloat)pixel;
        CGFloat y = (CGFloat)[[xAndYValues objectForKey:[NSNumber numberWithInt:pixel]] intValue];
        CGContextAddLineToPoint(context, x, y);
        CGContextMoveToPoint(context, x, y);
        
    }
    CGContextSetLineWidth(context, 1);
    [[UIColor blackColor] setStroke];
    CGContextStrokePath(context);
}
//this doesn't work yet

- (void)handleTap:(UITapGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateEnded){
        CGPoint tapLocation = [gesture locationInView:self];
        CGPoint origin = CGPointMake(self.origin.x +tapLocation.x, self.origin.y+tapLocation.y);
        [self setOrigin:origin];
        [self setNeedsDisplay];
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)){
        CGPoint translation = [gesture translationInView:self.superview];
         [self setOrigin:CGPointMake(self.origin.x+translation.x, self.origin.y+translation.y)];
        [gesture setTranslation:CGPointZero inView:self];
        [self setNeedsDisplay];
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)){
        CGFloat newScale = gesture.scale;
        [self setScale:newScale];
        gesture.scale = 0;
        [self setNeedsDisplay];
    }
}


@end
