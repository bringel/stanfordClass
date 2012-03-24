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

@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;
@synthesize toolbar = _toolbar;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;

- (void)setHappiness:(int)happiness{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem{
    if(_splitViewBarButtonItem != splitViewBarButtonItem){
        NSMutableArray *toolbarItems = [[self.toolbar items] mutableCopy];
        if(_splitViewBarButtonItem)
            [toolbarItems removeObject:_splitViewBarButtonItem];
        if(splitViewBarButtonItem)
            [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
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

- (float)happinessForFaceView{
    return (self.happiness - 50) / 50.0;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
