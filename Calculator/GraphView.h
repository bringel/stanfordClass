//
//  GraphView.h
//  Calculator
//
//  Created by Brad Ringel on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphViewDataSource.h"

@interface GraphView : UIView

@property (nonatomic) id <GraphViewDataSource> dataSource;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)pan:(UIPanGestureRecognizer *)gesture;
- (void)tap:(UITapGestureRecognizer *)gesture;


@end
