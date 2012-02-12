//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Brad Ringel on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (strong, nonatomic) NSMutableArray * operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack{
    if(_operandStack == nil)
        _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)pushOperand:(double)operand{
    [[self operandStack] addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand{
    NSNumber * topOfStack = [self.operandStack lastObject];
    if(topOfStack){
        [self.operandStack removeLastObject];
    }
    return [topOfStack doubleValue];
}

- (void)clearOperandStack{
    [self setOperandStack:nil];
}

- (double)performOperation:(NSString*)operation{
    double result = 0;
    
    if([operation isEqualToString:@"+"])
        result = [self popOperand] + [self popOperand];
    else if([operation isEqualToString:@"-"])
        result = [self popOperand] - [self popOperand];
    else if([operation isEqualToString:@"/"]){
        double divisor = [self popOperand];
        if(divisor)
            result = [self popOperand] / divisor;
    }
    else if([operation isEqualToString:@"*"])
        result = [self popOperand] * [self popOperand];
    else if([operation isEqualToString:@"sin"])
        result = sin([self popOperand]);
    else if([operation isEqualToString:@"cos"])
        result = cos([self popOperand]);
    else if([operation isEqualToString:@"sqrt"])
        result = sqrt([self popOperand]);
    else if([operation isEqualToString:@"π"])
        result = M_PI;

    [self pushOperand:result];
    return result;
}

@end
