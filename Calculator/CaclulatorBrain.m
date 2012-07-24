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
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CaclulatorBrain
@synthesize programStack = _programStack;

- (NSMutableArray *)programStack;
{
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}
 

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popHistoryOffProgramStack:stack];
}
+ (BOOL)isOperation:(NSString *)operation
{
    // What should i do with this method?
}
+ (NSString *)popHistoryOffProgramStack:(NSMutableArray *)stack;
{
    NSString *result;
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];

    if ([topOfStack isKindOfClass:[NSNumber class]]) {
         result = [NSString stringWithFormat:@"%g",[topOfStack doubleValue]];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        //copy from popOperandOffProgramStack, but each result will be 
        //operation equation vs.. answer
        //I could condense this down and combine 2 ops, 1 ops, 0 ops to
        //reduce the if/then
        if ([operation isEqualToString:@"+"]) {
            NSString *sumtrahend = [NSString stringWithFormat:@"%@",[self popHistoryOffProgramStack:stack]];
            result = [NSString stringWithFormat:@"(%@ + %@)",[self popHistoryOffProgramStack:stack],sumtrahend] ;
        } else if ([@"*" isEqualToString:operation]) {
            NSString *multrahend = [NSString stringWithFormat:@"%@",[self popHistoryOffProgramStack:stack]];
            result = [NSString stringWithFormat:@"(%@ * %@)",[self popHistoryOffProgramStack:stack],multrahend] ;
        } else if ([@"-" isEqualToString:operation]) {
            NSString *subtrahend = [NSString stringWithFormat:@"%@",[self popHistoryOffProgramStack:stack]];
            result = [NSString stringWithFormat:@"(%@ - %@)",[self popHistoryOffProgramStack:stack],subtrahend] ;
        } else if ([@"/" isEqualToString:operation]) {
            NSString *divisor = [NSString stringWithFormat:@"%@",[self popHistoryOffProgramStack:stack]];
            result = [NSString stringWithFormat:@"(%@ / %@)",[self popHistoryOffProgramStack:stack],divisor] ;
        } else if ([@"sin" isEqualToString:operation]) {
            result = [NSString stringWithFormat:@"sin(%@)",[self popHistoryOffProgramStack:stack]];
        } else if ([@"cos" isEqualToString:operation]) {
            result = [NSString stringWithFormat:@"cos(%@)",[self popHistoryOffProgramStack:stack]];
        } else if ([@"π" isEqualToString:operation]) {
             result = @"π";
        } else if ([@"+/-" isEqualToString:operation]) {
            result = [NSString stringWithFormat:@"-(%@)",[self popHistoryOffProgramStack:stack]];
        } else if ([@"sqrt" isEqualToString:operation]) {
            result = [NSString stringWithFormat:@"sqrt(%@)",[ self popHistoryOffProgramStack:stack]];
        } else {
            //must be a variable
            result = operation;
        }

    }
    return result;
}
- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
                                   
}
- (void)pushOperandString:(NSString *)operand
{
     [self.programStack addObject:operand];
    
}
- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack;
{
    double result = 0;
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];

    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        // perform the operation here, store answer in result
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack];
        } else if ([@"-" isEqualToString:operation]) {
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack ] - subtrahend;
        } else if ([@"/" isEqualToString:operation]) {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        } else if ([@"sin" isEqualToString:operation]) {
            result = sin([self popOperandOffProgramStack:stack ]); 
        } else if ([@"cos" isEqualToString:operation]) {
            result = cos([self popOperandOffProgramStack:stack ]);
        } else if ([@"π" isEqualToString:operation]) {
            result = M_PI;
        } else if ([@"+/-" isEqualToString:operation]) {
            result = -([self popOperandOffProgramStack:stack ]); 
        } else if ([@"sqrt" isEqualToString:operation]) {
            result = sqrt([self popOperandOffProgramStack:stack ]);
        }
    }
    
    return result;
}
    
- (void)clearBrain:(NSString *)operation
{
    self.programStack = nil; 
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
{
    //Finish this.. 
    //Replace the variables with there real values
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
        NSEnumerator *enumerator = [variableValues keyEnumerator];
        NSString *keyVar;
        
        while (keyVar = [enumerator nextObject]) {
            NSUInteger foundVar = [stack indexOfObject:keyVar];
            NSNumber *keyValue = [variableValues valueForKey:keyVar];                        
            [stack replaceObjectAtIndex:foundVar withObject:keyValue];
        }
    }
     return [self runProgram:stack];
}
+ (NSSet *)variablesUsedInProgram:(id)program; 
{
    NSArray *validOperations =[NSArray arrayWithObjects:@"+",@"-",@"/",@"*",@"sqrt",@"+/-",@"π",nil];

    NSMutableSet *usedVariables = [[NSMutableSet alloc] init ];
     if ([program isKindOfClass:[NSArray class]]) {
        NSArray *pStack = program;
        for (id progStatement in pStack) {
            if ([progStatement isKindOfClass:[NSNumber class]]) 
                continue;
            if ([progStatement isKindOfClass:[NSString class]]) {
                NSString *progOper = progStatement;
                //not in list, add to usedVariables
                if (![validOperations containsObject:progOper]) {
                    [usedVariables addObject:progOper]; 
                }
            }
         
        }
    }
     if ([usedVariables count])
         return [usedVariables copy];
     else 
         return nil;
     
}

@end
