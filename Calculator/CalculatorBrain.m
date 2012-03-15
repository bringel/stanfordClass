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

- (void)pushVariableAsOperand:(NSString *)variable{
    [self.programStack addObject:variable];
}

- (double)performOperation:(NSString *)operation{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:[self program]];
}

- (void)clearProgramStack{
    [self setProgramStack:nil];
}

+ (NSSet *)unaryOperators{
    return [[NSSet alloc] initWithObjects:@"sin",@"cos",@"sqrt", nil];
}

+ (NSSet *)binaryOperators{
    return [[NSSet alloc] initWithObjects:@"+",@"-",@"*",@"/", nil];
}

+ (NSSet *)noOperandOperators{
    return [[NSSet alloc] initWithObjects:@"π", nil];
}

+ (BOOL)isOperation:(NSString *)op{
    if([[CalculatorBrain unaryOperators] containsObject:op])
       return YES;
    else if([[CalculatorBrain binaryOperators] containsObject:op])
        return YES;
    else if([[CalculatorBrain noOperandOperators] containsObject:op])
        return YES;
    else
        return NO;
}

+ (NSSet *)variablesUsedInProgram:(id)program{
    NSMutableSet * variables = [[NSMutableSet alloc] init];
    NSMutableArray * stack;
    if([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    for(id stackItem in stack){
        if([stackItem isKindOfClass:[NSString class]]){
            if(![CalculatorBrain isOperation:stackItem])
                [variables addObject:stackItem];
        }
    }
    if([variables count] == 0)
        return nil;
    else
        return variables;
}

+ (NSString *)descriptionOfTopOfStack:(NSMutableArray *)stack{
    NSString * description = @"";
    id topOfStack = [stack lastObject];
    if(topOfStack)
        [stack removeLastObject];
    if([topOfStack isKindOfClass:[NSNumber class]]){
        description = [NSString stringWithFormat:@"%g",[topOfStack doubleValue]];
    }
    else if([topOfStack isKindOfClass:[NSString class]]) {
        if([CalculatorBrain isOperation:topOfStack]){
            if([[CalculatorBrain unaryOperators] containsObject:topOfStack]){
                NSString * insideOfOperation = [CalculatorBrain descriptionOfTopOfStack:stack];
                if([insideOfOperation hasPrefix:@"("]){
                    insideOfOperation = [insideOfOperation substringWithRange:NSMakeRange(1, [insideOfOperation length] - 2)];
                }
                description = [NSString stringWithFormat:@"%@(%@)",topOfStack,insideOfOperation];
            }
            else if([[CalculatorBrain binaryOperators] containsObject:topOfStack]){
                id operandTwo = [CalculatorBrain descriptionOfTopOfStack:stack];
                id operandOne = [CalculatorBrain descriptionOfTopOfStack:stack];
                description = [NSString stringWithFormat:@"(%@ %@ %@)",operandOne,topOfStack,operandTwo];
            }
            else if([[CalculatorBrain noOperandOperators] containsObject:topOfStack]){
                description = topOfStack;
            }
        }
        else {
            description = topOfStack;
        }
    }
    return description;
    
}

+ (NSString *)descriptionOfProgram:(id)program{
    NSMutableArray * stack;
    if([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    NSString * topDescription = [self descriptionOfTopOfStack:stack];
    if([stack count] == 0)
        return topDescription;
    else
        return [[NSString stringWithFormat:@"%@, ",[self descriptionOfProgram:stack]]stringByAppendingString:topDescription];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if(topOfStack)
        [stack removeLastObject];
    
    if([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }
    else if([topOfStack isKindOfClass:[NSString class]]){
        if([topOfStack isEqualToString:@"+"]){
            result = [CalculatorBrain popOperandOffProgramStack:stack] + [CalculatorBrain popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"-"]){
            result = [CalculatorBrain popOperandOffProgramStack:stack] - [CalculatorBrain popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"*"]){
            result = [CalculatorBrain popOperandOffProgramStack:stack] * [CalculatorBrain popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"/"]){
            result = [CalculatorBrain popOperandOffProgramStack:stack] / [CalculatorBrain popOperandOffProgramStack:stack];
        }
        else if([topOfStack isEqualToString:@"sin"]){
            result = sin([CalculatorBrain popOperandOffProgramStack:stack]);
        }
        else if([topOfStack isEqualToString:@"cos"]){
            result = cos([CalculatorBrain popOperandOffProgramStack:stack]);
        }
        else if([topOfStack isEqualToString:@"sqrt"]){
            result = sqrt([CalculatorBrain popOperandOffProgramStack:stack]);
        }
        else if([topOfStack isEqualToString:@"π"]){
            //result = [self popOperandOffProgramStack:[self programStack]] - [self popOperandOffProgramStack:[self programStack]];
            result = M_PI;
        }
    }
    return result;
}

+ (double)runProgram:(id)program{
    NSMutableArray * stack;
    if([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    return [self popOperandOffProgramStack:stack];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues{
    NSMutableArray * stack;
    if([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    NSSet * variablesInProgram = [CalculatorBrain variablesUsedInProgram:stack];
    for(int index = 0; index < [stack count]; index++){
        id topOfStack = [stack objectAtIndex:index];
        if([topOfStack isKindOfClass:[NSString class]]){
            if([variablesInProgram containsObject:topOfStack]){
                [stack replaceObjectAtIndex:index withObject:[variableValues objectForKey:topOfStack]];
            }
        }
    }
    return [CalculatorBrain runProgram:stack];
}

@end
