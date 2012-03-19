//
//  GraphView.m
//  Calculator
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"

@interface GraphView()

@property (nonatomic) CGPoint origin;

@end

@implementation GraphView

@synthesize origin = _origin;
@synthesize dataSource = _dataSource;

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
}
#define DEFAULT_SCALE 10.0

- (void)drawRect:(CGRect)rect
{
    [AxesDrawer drawAxesInRect:[self bounds] originAtPoint:[self origin] scale:DEFAULT_SCALE];
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


@end
