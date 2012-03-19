//
//  GraphView.h
//  Calculator
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxesDrawer.h"
#import "GraphViewDataSource.h"


@interface GraphView : UIView

@property (nonatomic, weak) id <GraphViewDataSource> dataSource;

@end
