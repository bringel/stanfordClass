//
//  GraphViewController.h
//  Calculator
//
//  Created by Brad Ringel on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface GraphViewController : UIViewController

@property (nonatomic, strong) NSArray * function;
@property (nonatomic, weak) IBOutlet GraphView * graph;

@end
