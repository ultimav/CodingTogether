//
//  CaclulatorBrain.m
//  Calculator
//
//  Created by Dana Cleveland on 7/14/12.
//  Version #1 for Assignment 1
//  Copyright (c) 2012 Scritchy.org. All rights reserved.
//

#import "CaclulatorBrain.h"

@interface CaclulatorBrain() 
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CaclulatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack;
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}
 
- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}
- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}
- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    // perform the operation here, store answer in result
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([@"-" isEqualToString:operation]) {
        double subtrahend = [self popOperand];
        result = [self popOperand ] - subtrahend;
    } else if ([@"/" isEqualToString:operation]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([@"sin" isEqualToString:operation]) {
        result = sin([self popOperand ]); 
    } else if ([@"cos" isEqualToString:operation]) {
        result = cos([self popOperand ]);
    } else if ([@"π" isEqualToString:operation]) {
        result = M_PI;
    } else if ([@"+/-" isEqualToString:operation]) {
        result = -([self popOperand ]); 
    }
    
    [self pushOperand:result];
    
    return result;
}
- (void)clearBrain:(NSString *)operation
{
    self.operandStack = nil; 
}
@end
