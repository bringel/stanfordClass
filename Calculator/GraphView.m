//
//  GraphView.m
//  Calculator
//
//  Created by Brad Ringel on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"
#import "CalculatorBrain.h"

@interface GraphView()

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat scale;

@end

@implementation GraphView

@synthesize dataSource = _dataSource;
@synthesize origin = _origin;
@synthesize scale = _scale;

- (void)setup{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tap setNumberOfTapsRequired:3];
    [self addGestureRecognizer:pinch];
    [self addGestureRecognizer:pan];
    [self addGestureRecognizer:tap];
    CGPoint origin = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2);
    [self setOrigin:origin];
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

#define DEFAULT_SCALE 10.0

- (CGFloat)scale{
    if(_scale == 0)
        _scale = DEFAULT_SCALE;
    return _scale;
}

- (void)setScale:(CGFloat)scale{
    if(scale != _scale)
        _scale = scale;
}

//for some reason this method is off by one every time. have to investigate that

- (NSDictionary *)calculateValuesFromFunction:(NSArray *)function{
    NSMutableDictionary *functionValues = [[NSMutableDictionary alloc] init];
    //in here we iterate over all the x values in the screen and calculate the proper y values.
    //don't forget to convert using self.origin and self.scale
    CGFloat width = (self.bounds.size.width) * (self.contentScaleFactor);
    for(float pixel = 0.0f; pixel <= width; pixel ++){
        float point = (pixel - self.origin.x) / self.scale;
        NSDictionary *variableValues = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:point], @"x", nil];
        double result = -1 *[CalculatorBrain runProgram:function usingVariableValues:variableValues];
        [functionValues setObject:[NSNumber numberWithFloat:result] forKey:[NSNumber numberWithFloat:point]];
    }
    
    return [functionValues copy];
}

- (void)drawRect:(CGRect)rect{
    // Drawing code
    [AxesDrawer drawAxesInRect:[self bounds] originAtPoint:[self origin] scale:[self scale]];
    //here we iterate over all the x values in self.bounds.size.width and draw lines to each point
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSDictionary *functionValues = [self calculateValuesFromFunction:[self.dataSource setFunctionForGraphView]];
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGPointZero.x, CGPointZero.y);
    for(float pixel = 1; pixel < self.bounds.size.width; pixel ++){
        CGFloat point = (pixel - self.origin.x) / self.scale;
        CGFloat yValue = [[functionValues objectForKey:[NSNumber numberWithFloat:point]] floatValue];
        point *= self.scale;
        yValue *= self.scale;
        point +=self.origin.x;
        yValue += self.origin.y;
        CGContextAddLineToPoint(context, point, yValue);
        CGContextMoveToPoint(context, point, yValue);
    }
    [[UIColor blackColor] setStroke];
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)){
        CGFloat scale = gesture.scale;
        [self setScale:self.scale * scale];
        gesture.scale = 1;
        [self setNeedsDisplay];
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)){
        CGFloat x = (self.origin.x + [gesture translationInView:self].x);
        CGFloat y = (self.origin.y + [gesture translationInView:self].y);
        [self setOrigin:CGPointMake(x, y)];
        [gesture setTranslation:CGPointZero inView:self];
        [self setNeedsDisplay];
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateEnded){
        CGPoint location = [gesture locationOfTouch:0 inView:self];
        [self setOrigin:CGPointMake(location.x, location.y)];
        [self setNeedsDisplay];
    }
}


@end
