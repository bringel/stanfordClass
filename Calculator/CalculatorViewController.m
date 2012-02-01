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
@property (strong, nonatomic) CalculatorBrain * brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsEnteringNumber = _userIsEnteringNumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain{
    if(_brain == nil)
        _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

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
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self setUserIsEnteringNumber:NO];
}

- (IBAction)operatorPressed:(UIButton *)sender {
    if([self userIsEnteringNumber])
       [self enterPressed];
       
    NSString * operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    [self.display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
