//
//  GraphViewController.m
//  Calculator
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphViewDataSource.h"
#import "CalculatorBrain.h"

@interface GraphViewController () <GraphViewDataSource>


@end

@implementation GraphViewController

@synthesize graph = _graph;
@synthesize function = _function;
@synthesize toolbar = _toolbar;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;

- (void)setGraph:(GraphView *)graph{
    _graph = graph;
    [self.graph setDataSource:self];
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem{
    NSMutableArray *toobarItems = [[[self toolbar] items] mutableCopy];
    if(_splitViewBarButtonItem != splitViewBarButtonItem){
        if(_splitViewBarButtonItem)
            [toobarItems removeObject:_splitViewBarButtonItem];
        if(splitViewBarButtonItem){
            [toobarItems insertObject:splitViewBarButtonItem atIndex:0];
            [toobarItems insertObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] atIndex:1];
            [toobarItems insertObject:[[UIBarButtonItem alloc] initWithTitle:[CalculatorBrain descriptionOfProgram:self.function] style:UIBarButtonItemStylePlain target:nil action:nil] atIndex:2];
            [toobarItems insertObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] atIndex:3];
        }
        self.toolbar.items = [toobarItems copy];
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}

- (NSArray *)setFunctionForGraphView{
    return [self function];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
