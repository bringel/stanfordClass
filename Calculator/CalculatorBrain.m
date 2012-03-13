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

- (double)popOperandOffProgramStack:(NSMutableArray *)stack{
    return [[stack lastObject] doubleValue];
}

- (double)performOperation:(NSString *)operation{
    double result;
    
    if([operation isEqualToString:@"+"]){
        result = [self popOperandOffProgramStack:[self programStack]] + [self popOperandOffProgramStack:[self programStack]];
    }
    else if([operation isEqualToString:@"-"]){
        result = [self popOperandOffProgramStack:[self programStack]] - [self popOperandOffProgramStack:[self programStack]];
    }
    else if([operation isEqualToString:@"*"]){
        result = [self popOperandOffProgramStack:[self programStack]] * [self popOperandOffProgramStack:[self programStack]];
    }
    else if([operation isEqualToString:@"/"]){
        result = [self popOperandOffProgramStack:[self programStack]] / [self popOperandOffProgramStack:[self programStack]];
    }
    else if([operation isEqualToString:@"sin"]){
        result = sin([self popOperandOffProgramStack:[self programStack]]);
    }
    else if([operation isEqualToString:@"cos"]){
        result = cos([self popOperandOffProgramStack:[self programStack]]);
    }
    else if([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperandOffProgramStack:[self programStack]]);
    }
    else if([operation isEqualToString:@"π"]){
        //result = [self popOperandOffProgramStack:[self programStack]] - [self popOperandOffProgramStack:[self programStack]];
        result = M_PI;
    }
    
    [self pushOperand:result];
    return result;
}

- (void)clearProgramStack{
    [self setProgramStack:nil];
}

+ (NSString *)descriptionOfProgram:(id)program{
    
}

+ (double)runProgram:(id)program{
    NSMutableArray * stack;
    if([program isKindOfClass:[NSArray class]])
        stack = [program copy];
    
}

@end
