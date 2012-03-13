//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Brad Ringel on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (strong, nonatomic) NSMutableArray * programStack;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack{
    if(_programStack == nil)
        _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (id)program{
    return [self.programStack copy];
}

- (void)pushOperand:(double)operand{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if(topOfStack)
        [stack removeLastObject];
    
    if([topOfStack isKindOfClass:[NSString class]]){
        if([topOfStack isEqualToString:@"+"]){
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"-"]){
            result = [self popOperandOffProgramStack:stack] - [self popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"*"]){
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"/"]){
            result = [self popOperandOffProgramStack:stack] / [self popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"sin"]){
            result = sin([self popOperandOffProgramStack:stack]);
        }
        else if([topOfStack isEqualToString:@"cos"]){
            result = cos([self popOperandOffProgramStack:stack]);
        }
        else if([topOfStack isEqualToString:@"sqrt"]){
            result = sqrt([self popOperandOffProgramStack:stack]);
        }
        else if([topOfStack isEqualToString:@"π"]){
            //result = [self popOperandOffProgramStack:[self programStack]] - [self popOperandOffProgramStack:[self programStack]];
            result = M_PI;
        }
    }
    else if([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }
    return result;
}

- (double)performOperation:(NSString *)operation{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:[self program]];
}

- (void)clearProgramStack{
    [self setProgramStack:nil];
}

+ (NSString *)descriptionOfProgram:(id)program{
    return @"Implement this later";
}

+ (double)runProgram:(id)program{
    NSMutableArray * stack;
    if([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    return [self popOperandOffProgramStack:stack];
}

@end
