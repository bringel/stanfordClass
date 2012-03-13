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
@property (nonatomic) BOOL userHasChangedSign;
@property (strong, nonatomic) CalculatorBrain * brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize historyDisplay = _historyDisplay;
@synthesize variablesDisplay = _variablesDisplay;
@synthesize userIsEnteringNumber = _userIsEnteringNumber;
@synthesize userHasChangedSign = _userHasChangedSign;
@synthesize userHasPressedDecimal = _userHasPressedDecimal;
@synthesize brain = _brain;

- (CalculatorBrain *)brain{
    if(_brain == nil)
        _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    if([self userIsEnteringNumber]){
        [self.display setText:[self.display.text stringByAppendingString:[sender currentTitle]]];
    }
    else {
        [self.display setText:[sender currentTitle]];
        [self setUserIsEnteringNumber:YES];
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[[self.display text] doubleValue]];
    [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@"%@ ",[self.display text]]];
    [self setUserIsEnteringNumber:NO];
    [self setUserHasPressedDecimal:NO];
    [self setUserHasChangedSign:NO];
}

- (IBAction)operatorPressed:(UIButton *)sender {
    [self enterPressed];
    [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@"%@ ",[sender currentTitle]]];
    [self.display setText:[NSString stringWithFormat:@"%g",[self.brain performOperation:[sender currentTitle]]]];
}

- (IBAction)decimalPressed {
    if(![self userHasPressedDecimal]){
        [self.display setText:[self.display.text stringByAppendingString:@"."]];
        [self setUserHasPressedDecimal:YES];
        [self setUserIsEnteringNumber:YES];
    }
}

- (IBAction)signChangePressed {
    if([self userHasChangedSign]){
        [self.display setText:[self.display.text substringFromIndex:1]];
        [self setUserHasChangedSign:NO];
    }
    else {
        [self.display setText:[@"-" stringByAppendingString:[self.display text]]];
        [self setUserHasChangedSign:YES];
    }
}

- (IBAction)clearPressed {
    [self.display setText:@"0"];
    [self.historyDisplay setText:@"  "];
    [self.brain clearProgramStack];
    [self setUserHasChangedSign:NO];
    [self setUserIsEnteringNumber:NO];
    [self setUserHasPressedDecimal:NO];
}

- (IBAction)undoPressed {
    if([self.display.text length] > 1){
        [self.display setText:[self.display.text substringToIndex:[self.display.text length] - 1]];
    }
    else {
        [self.display setText:@"0"];
        [self setUserIsEnteringNumber:NO];
        [self setUserHasPressedDecimal:NO];
        [self setUserHasChangedSign:NO];
    }
}

- (IBAction)variablePressed:(UIButton *)sender {
}

- (IBAction)variableTestPressed:(id)sender {
}


@end
