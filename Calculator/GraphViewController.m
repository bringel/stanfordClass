//
//  GraphViewController.m
//  Calculator
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphViewDataSource.h"

@interface GraphViewController () <GraphViewDataSource>


@end

@implementation GraphViewController

@synthesize graph = _graph;
@synthesize function = _function;

- (void)setGraph:(GraphView *)graph{
    _graph = graph;
    [self.graph setDataSource:self];
}

- (NSArray *)setFunctionForGraphView{
    return [self function];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
