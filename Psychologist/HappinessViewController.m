//
//  HappinessViewController.m
//  Happiness
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController () <FaceViewDataSource>

@property (weak, nonatomic) IBOutlet FaceView * faceView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) UIPopoverController *popoverVC;

@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;
@synthesize toolbar = _toolbar;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;
@synthesize popoverVC = _popoverVC;

- (UIPopoverController *)popoverVC{
    if(_popoverVC == nil){
        _popoverVC = [[UIPopoverController alloc] initWithContentViewController:[self.splitViewController.viewControllers objectAtIndex:0]];
    }
    return _popoverVC;
}

- (void)setHappiness:(int)happiness{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem{
    if(_splitViewBarButtonItem != splitViewBarButtonItem){
        NSMutableArray *toolbarItems = [[self.toolbar items] mutableCopy];
        if(_splitViewBarButtonItem)
            [toolbarItems removeObject:_splitViewBarButtonItem];
        if(splitViewBarButtonItem){
            [splitViewBarButtonItem setTitle:@"Psychologist"];
            [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
            [splitViewBarButtonItem setTarget:self];
            [splitViewBarButtonItem setAction:@selector(showPsychologistPopover:)];
        }
        self.toolbar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}

- (void)setFaceView:(FaceView *)faceView{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappiness:)]];
    [self.faceView setDataSource:self];
}

- (void)handleHappiness:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:self.faceView];
    [self setHappiness:self.happiness -= translation.y /2];
    [gesture setTranslation:CGPointZero inView:self.faceView];
}

- (IBAction)showPsychologistPopover:(id)sender{
    [self.popoverVC presentPopoverFromBarButtonItem:self.splitViewBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (float)happinessForFaceView{
    return (self.happiness - 50) / 50.0;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
