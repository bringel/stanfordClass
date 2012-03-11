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
    
}

- (id)program{
     
}

- (void)pushOperand:(double)operand{
    
}

- (double)popOperandOffProgramStack:(NSMutableArray *)stack{
    
}

- (double)performOperation:(NSString *)operation{
    
}

- (void)clearProgramStack{
    
}

+ (NSString *)descriptionOfProgram:(id)program{
    
}

+ (double)runProgram:(id)program{
    
}

@end
