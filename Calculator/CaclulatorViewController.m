//
//  CaclulatorViewController.m
//  Calculator
//
//  Created by Dana Cleveland on 7/13/12.
//  Copyright (c) 2012 Scritchy.org. All rights reserved.
//  Version 3 for Assignment 3

#import "CaclulatorViewController.h"
#import "CaclulatorBrain.h"
#import "GraphViewController.h"

@interface CaclulatorViewController ()
@property (nonatomic)BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic)BOOL userCanUseOnlyOneInANumber;
@property (nonatomic)BOOL usingAVariable;
@property (nonatomic,strong) CaclulatorBrain *brain;
@property (nonatomic,strong) NSDictionary *variablesValues;
@end

@implementation CaclulatorViewController

@synthesize display = _display; //instantiates as 0(nil), like all pointers
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber; //instantiates as 0(NO)
@synthesize userCanUseOnlyOneInANumber = _userCanUseOnlyOneInANumber;
@synthesize brain = _brain;
@synthesize variablesValues = _variablesValues;
@synthesize usingAVariable = _usingAVariable;

- (CaclulatorBrain *)brain
{
    if (!_brain) _brain = [[CaclulatorBrain alloc] init];
    return _brain;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Graph"] ){
        [segue.destinationViewController setProgramToGraph:self.brain.program] ;
    }
}
- (IBAction)graphProgram
{
    [self performSegueWithIdentifier:@"Graph" sender:self];
}
 
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [ sender currentTitle];
    //NSLog(@"user touched %@",digit);
    if (([digit isEqualToString:@"."]) ||
         ([digit isEqualToString:@"x"]) ) {
        if (self.userCanUseOnlyOneInANumber) {
             digit = @"";
        } else {
            self.userCanUseOnlyOneInANumber = YES;
            if (![digit isEqualToString:@"."]) {
                self.usingAVariable = YES;
            } else {
                self.usingAVariable = NO;
            }
        }
    } 
     
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [ self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
        
    }
    
}
- (IBAction)enterPressed 
{
 
    if (self.usingAVariable) {
        [self.brain pushOperandString:self.display.text];
    } else {
        [self.brain pushOperand:[self.display.text doubleValue]];
    }
    //[self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userCanUseOnlyOneInANumber = NO;
    [self updateHistory]; // self.display.text oper:NO];
}

- (IBAction)operationPressed:(UIButton *)sender
{
    BOOL switchSign = NO;
    NSString *operation = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if ([operation isEqualToString:@"+/-"]) {
            switchSign = YES;
        } else {
             [self enterPressed];
        }
    }
    
    self.display.text = [NSString stringWithFormat:@"-%g",self.display.text];
    if (!switchSign) {
        double result = 0;
        if (![[self.brain class] variablesUsedInProgram:[self.brain program]])
        {
            result = [self.brain performOperation:operation];
        } else {
            [self.brain pushOperandString:operation];
        }
        [self updateHistory]; //:operation oper:YES];
        self.display.text = [NSString stringWithFormat:@"%g",result];
    }
    
 }

- (IBAction)clearPressed
{
    self.display.text = @"0";
    [self.brain clearBrain:@""];
    [self enterPressed];
    [self updateHistory]; //:@"Clear" oper:NO];
}

- (IBAction)backspacePressed
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        NSUInteger lengthMinOne = [self.display.text length] - 1;
        self.display.text = [self.display.text substringToIndex: lengthMinOne];
    }
    
}
- (void)updateHistory
{
    self.history.text = [[self.brain class] descriptionOfProgram:self.brain.program];
}
- (void)updateHistoryText:(NSString *)historyItem oper:(BOOL)omode
{
    NSString *equalsSign = @"=";
    if (!omode)
        equalsSign = @"";
    
    if ([historyItem isEqualToString:@"Clear"]) {
        self.history.text = @"";
    } else {
        NSRange removeEquals = [ self.history.text rangeOfString:@"="];
        if (removeEquals.location != NSNotFound)
            self.history.text = [self.history.text substringToIndex:removeEquals.location];
        self.history.text = [self.history.text stringByAppendingFormat:@"%@%@ ",historyItem,equalsSign];
    }
}
@end
