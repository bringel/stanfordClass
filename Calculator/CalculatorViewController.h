//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Brad Ringel on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *historyDisplay;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
