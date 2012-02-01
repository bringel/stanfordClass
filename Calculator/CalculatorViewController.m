//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Brad Ringel on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()

@property (nonatomic) BOOL userIsEnteringNumber;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsEnteringNumber = _userIsEnteringNumber;

- (IBAction)digitPressed:(UIButton *)sender {
    NSString * digit = [sender currentTitle];
    
    if(![self userIsEnteringNumber]){
        [self.display setText:digit];
        [self setUserIsEnteringNumber:YES];
    }
    else
        [self.display setText:[self.display.text stringByAppendingString:digit]];
}

- (IBAction)enterPressed {
}

- (IBAction)operatorPressed:(UIButton *)sender {
}

@end
