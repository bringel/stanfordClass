//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Brad Ringel on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearProgramStack;

@property (nonatomic, readonly) id program;
+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;

@end
