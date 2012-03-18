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

@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (void)setHappiness:(int)happiness{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
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
