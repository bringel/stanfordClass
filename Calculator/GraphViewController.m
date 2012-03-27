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

- (void)awakeFromNib{
    [super awakeFromNib];
    if(self.splitViewController)
        self.splitViewController.delegate = self;
}

- (void)setFunction:(NSArray *)function{
    if(_function != function){
        _function = function;
        [self.graph setNeedsDisplay];
        NSMutableArray *toolbarItems = [[self.toolbar items] mutableCopy];
        while ([toolbarItems count] > 1) {
            [toolbarItems removeLastObject];
        }
        [toolbarItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        [toolbarItems addObject:[[UIBarButtonItem alloc] initWithTitle:[CalculatorBrain descriptionOfProgram:self.function] style:UIBarButtonItemStylePlain target:nil action:nil]];
        [toolbarItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        self.toolbar.items = [toolbarItems copy];
    }
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem{
    NSMutableArray *toobarItems = [[[self toolbar] items] mutableCopy];
    if(_splitViewBarButtonItem != splitViewBarButtonItem){
        if(_splitViewBarButtonItem)
            [toobarItems removeObject:_splitViewBarButtonItem];
        if(splitViewBarButtonItem){
            [toobarItems insertObject:splitViewBarButtonItem atIndex:0];
        }
        self.toolbar.items = [toobarItems copy];
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}

- (NSArray *)setFunctionForGraphView{
    return [self function];
}

- (void)viewDidLoad{
    if([self splitViewController])
        self.splitViewController.delegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    [barButtonItem setTitle:@"Calculator"];
    [[self.splitViewController.viewControllers lastObject] setSplitViewBarButtonItem: barButtonItem];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [[self.splitViewController.viewControllers lastObject] setSplitViewBarButtonItem:nil];
}

@end
