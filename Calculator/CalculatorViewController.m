//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Brad Ringel on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()

@property (nonatomic) BOOL userIsEnteringNumber;
@property (nonatomic) BOOL userHasPressedDecimal;
@property (strong, nonatomic) CalculatorBrain * brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize historyDisplay = _historyDisplay;
@synthesize variablesDisplay = _variablesDisplay;
@synthesize userIsEnteringNumber = _userIsEnteringNumber;
@synthesize userHasPressedDecimal = _userHasPressedDecimal;
@synthesize brain = _brain;

- (CalculatorBrain *)brain{
    
}

- (IBAction)digitPressed:(UIButton *)sender {
}

- (IBAction)operatorPressed:(UIButton *)sender {
    
}

- (IBAction)enterPressed {
}

- (IBAction)decimalPressed {
}

- (IBAction)signChangePressed {
}

- (IBAction)clearPressed {
}

- (IBAction)undoPressed {
}

- (IBAction)variablePressed:(UIButton *)sender {
}

- (IBAction)variableTestPressed:(id)sender {
}


@end
