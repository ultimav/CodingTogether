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
- (double)performOperation:(NSString *)operation;
- (void)clearBrain:(NSString *)operation;
@end
