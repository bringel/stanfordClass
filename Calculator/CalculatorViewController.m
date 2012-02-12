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
@synthesize userIsEnteringNumber = _userIsEnteringNumber;
@synthesize userHasPressedDecimal = _userHasPressedDecimal;
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

- (IBAction)decimalPressed {
    if(![self userHasPressedDecimal]){
        [self.display setText:[self.display.text stringByAppendingString:@"."]];
        [self setUserHasPressedDecimal:YES];
    }
}

- (IBAction)backspacePressed {
    if([self userIsEnteringNumber]){
        if([self.display.text length] > 1)
            [self.display setText:[self.display.text substringToIndex:[self.display.text length] - 1]];
        else
            [self.display setText:@"0"];
    }
}

- (IBAction)signChangePressed {
    if([self userIsEnteringNumber])
        [self.display setText:[@"-" stringByAppendingString:[self.display text]]];
    else 
        [self.brain performOperation:@"+/-"];
}

- (IBAction)enterPressed {
    [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@"%@ ",[self.display text]]];
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self setUserIsEnteringNumber:NO];
    [self setUserHasPressedDecimal:NO];
}

- (IBAction)clearPressed {
    [self.historyDisplay setText:@""];
    [self.display setText:@"0"];
    [self setUserIsEnteringNumber:NO];
    [self setUserHasPressedDecimal:NO];
    [self.brain clearOperandStack];
}

- (IBAction)operatorPressed:(UIButton *)sender {
    if([self userIsEnteringNumber])
       [self enterPressed];
    [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@"%@ ",[sender currentTitle]]];
    NSString * operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    [self.display setText:[NSString stringWithFormat:@"%g", result]];
}


@end
