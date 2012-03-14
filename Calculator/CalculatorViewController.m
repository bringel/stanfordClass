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
//    [self.historyDisplay setText:[[self.historyDisplay.text substringToIndex:[self.historyDisplay.text length] - 1] stringByAppendingFormat:@"%@  ",[self.display text]]];
    [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@" %@",[CalculatorBrain descriptionOfProgram:[self.brain program]]]];
    [self setUserIsEnteringNumber:NO];
    [self setUserHasPressedDecimal:NO];
    [self setUserHasChangedSign:NO];
}

- (IBAction)operatorPressed:(UIButton *)sender {
    if([self userIsEnteringNumber])
        [self enterPressed];
//    [self.historyDisplay setText:[[self.historyDisplay.text substringToIndex:[self.historyDisplay.text length] -1] stringByAppendingFormat:@"%@ =",[sender currentTitle]]];
    [self.display setText:[NSString stringWithFormat:@"%g",[self.brain performOperation:[sender currentTitle]]]];
    [self.historyDisplay setText:[CalculatorBrain descriptionOfProgram:[self.brain program]]];
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
    [self.variablesDisplay setText:@""];
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
    [self.brain pushVariableAsOperand:[sender currentTitle]];
    [self.historyDisplay setText:[[self.historyDisplay.text substringToIndex:[self.historyDisplay.text length] -1] stringByAppendingFormat:@"%@  ",[sender currentTitle]]];
    if(![self.variablesDisplay.text rangeOfString:[sender currentTitle]].length)
        [self.variablesDisplay setText:[self.variablesDisplay.text stringByAppendingFormat:@"%@ = 0 ",[sender currentTitle]]];
}

- (IBAction)variableTestPressed:(id)sender {
    NSMutableDictionary * variableValues = [[NSMutableDictionary alloc] init];
    NSSet * variables = [CalculatorBrain variablesUsedInProgram:[self.brain program]];
    if([[sender currentTitle] isEqualToString:@"Test 1"])
        for(NSString * variable in variables){
            [variableValues setValue:nil forKey:variable];
        }
    else if([[sender currentTitle] isEqualToString:@"Test 2"]){
        if([variables containsObject:@"x"]){
            [variableValues setObject:[NSNumber numberWithDouble:7] forKey:@"x"];
        }
        if([variables containsObject:@"a"])
            [variableValues setObject:[NSNumber numberWithDouble:19] forKey:@"a"];
        if([variables containsObject:@"b"])
            [variableValues setObject:[NSNumber numberWithDouble:1] forKey:@"b"];
    }
    else if([[sender currentTitle] isEqualToString:@"Test 3"]){
        if([variables containsObject:@"x"])
            [variableValues setObject:[NSNumber numberWithDouble: 0] forKey:@"x"];
        if([variables containsObject:@"a"])
            [variableValues setObject:[NSNumber numberWithDouble:25] forKey:@"a"];
        if([variables containsObject:@"b"])
            [variableValues setObject:[NSNumber numberWithDouble:10] forKey:@"b"];
    }
    NSMutableString * newVariables = [[NSMutableString alloc] init];
    for(NSString * var in variables){
        [newVariables appendFormat:@"%@ = %@ ",var, [variableValues objectForKey:var]];
    }
    [self.variablesDisplay setText:[newVariables copy]];
    [self.display setText:[NSString stringWithFormat:@"%g",[CalculatorBrain runProgram:[self.brain program] usingVariableValues:variableValues]]];
}


@end
