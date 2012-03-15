//
//  GraphView.m
//  Calculator
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setNeedsDisplay];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [AxesDrawer drawAxesInRect:[self bounds] originAtPoint:[self center] scale:[self contentScaleFactor]];
}


@end
