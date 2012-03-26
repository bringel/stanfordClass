//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Brad Ringel on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "GraphViewController.h"

@interface CalculatorViewController()

@property (nonatomic) BOOL userIsEnteringNumber;
@property (nonatomic) BOOL userHasPressedDecimal;
@property (nonatomic) BOOL userHasChangedSign;
@property (strong, nonatomic) CalculatorBrain * brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize historyDisplay = _historyDisplay;
@synthesize userIsEnteringNumber = _userIsEnteringNumber;
@synthesize userHasChangedSign = _userHasChangedSign;
@synthesize userHasPressedDecimal = _userHasPressedDecimal;
@synthesize brain = _brain;

- (void)awakeFromNib{
    [super awakeFromNib];
    if([self splitViewController])
        [self splitViewController].delegate = self;
}

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
//    [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@" %@,",[CalculatorBrain descriptionOfProgram:[self.brain program]]]];
    [self.historyDisplay setText:[CalculatorBrain descriptionOfProgram:[self.brain program]]];
    [self setUserIsEnteringNumber:NO];
    [self setUserHasPressedDecimal:NO];
    [self setUserHasChangedSign:NO];
}

- (IBAction)operatorPressed:(UIButton *)sender {
    if([self userIsEnteringNumber])
        [self enterPressed];
    [self.display setText:[NSString stringWithFormat:@"%g",[self.brain performOperation:[sender currentTitle]]]];
//    if([self userIsEnteringNumber])
//        [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@" %@,",[CalculatorBrain descriptionOfProgram:[self.brain program]]]];
//    else 
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
    [self.brain clearProgramStack];
    [self setUserHasChangedSign:NO];
    [self setUserIsEnteringNumber:NO];
    [self setUserHasPressedDecimal:NO];
}

- (IBAction)undoPressed {
    if([self userIsEnteringNumber]){
        if([self.display.text length] > 1){
            [self.display setText:[self.display.text substringToIndex:[self.display.text length] - 1]];
        }
        else {
            [self.display setText:[NSString stringWithFormat:@"%g",[CalculatorBrain runProgram:[self.brain program]]]];
            [self setUserIsEnteringNumber:NO];
            [self setUserHasPressedDecimal:NO];
            [self setUserHasChangedSign:NO];
        }
    }
    else {
        [self.brain removeItemFromProgramStack];
        [self.display setText:[NSString stringWithFormat:@"%g",[CalculatorBrain runProgram:[self.brain program]]]];
        [self.historyDisplay setText:[CalculatorBrain descriptionOfProgram:[self.brain program]]];
    }
}

- (IBAction)variablePressed:(UIButton *)sender {
    [self.brain pushVariableAsOperand:[sender currentTitle]];
    [self.historyDisplay setText:[self.historyDisplay.text stringByAppendingFormat:@" %@",[CalculatorBrain descriptionOfProgram:[self.brain program]]]];
}

- (void)viewDidLoad{
    [self splitViewController].delegate = self;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    [barButtonItem setTitle:[CalculatorBrain descriptionOfProgram:self.brain.program]];
    [[self.splitViewController.viewControllers lastObject] setSplitViewBarButtonItem: barButtonItem];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [[self.splitViewController.viewControllers lastObject] setSplitViewBarButtonItem:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowGraph"]){
        [segue.destinationViewController setFunction:self.brain.program];
    }
}

@end
