//
//  FaceView.h
//  Happiness
//
//  Created by Brad Ringel on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceViewDataSource <NSObject>

- (float)happinessForFaceView;

@end

@interface FaceView : UIView

@property (nonatomic) CGFloat scale;
@property (nonatomic, weak) id <FaceViewDataSource> dataSource;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
