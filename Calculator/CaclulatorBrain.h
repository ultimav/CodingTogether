//
//  CaclulatorBrain.h
//  Calculator
//
//  Created by Dana Cleveland on 7/14/12.
//  Version #1 for Assignment 1
//  Copyright (c) 2012 Scritchy.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaclulatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (void)pushOperandString:(NSString *) operand;
- (double)performOperation:(NSString *)operation;
- (void)clearBrain:(NSString *)operation;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+ (NSSet *)variablesUsedInProgram:(id)program;
@end
