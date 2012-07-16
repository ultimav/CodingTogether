//
//  CaclulatorViewController.m
//  Calculator
//
//  Created by Dana Cleveland on 7/13/12.
//  Copyright (c) 2012 Scritchy.org. All rights reserved.
//

#import "CaclulatorViewController.h"
#import "CaclulatorBrain.h"

@interface CaclulatorViewController ()
@property (nonatomic)BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic)BOOL userUsedTheDecimalInANumber;
@property (nonatomic,strong) CaclulatorBrain *brain;
@end

@implementation CaclulatorViewController

@synthesize display = _display; //instantiates as 0(nil), like all pointers
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber; //instantiates as 0(NO)
@synthesize userUsedTheDecimalInANumber = _userUsedTheDecimalInANumber;
@synthesize brain = _brain;

- (CaclulatorBrain *)brain
{
    if (!_brain) _brain = [[CaclulatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [ sender currentTitle];
    //NSLog(@"user touched %@",digit);
    if ([digit isEqualToString:@"."]) {
        if (self.userUsedTheDecimalInANumber) {
             digit = @"";
        } else {
            self.userUsedTheDecimalInANumber = YES;
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
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userUsedTheDecimalInANumber = NO;
    [self updateHistory:self.display.text oper:NO];
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
    double result = -[self.display.text doubleValue];
    if (!switchSign) {
        result = [self.brain performOperation:operation];
        [self updateHistory:operation oper:YES];
    }
    self.display.text = [NSString stringWithFormat:@"%g",result];
 }

- (IBAction)clearPressed
{
    self.display.text = @"0";
    [self.brain clearBrain:@""];
    [self enterPressed];
    [self updateHistory:@"Clear" oper:NO];
}

- (IBAction)backspacePressed
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        NSUInteger lengthMinOne = [self.display.text length] - 1;
        self.display.text = [self.display.text substringToIndex: lengthMinOne];
    }
    
}

- (void)updateHistory:(NSString *)historyItem oper:(BOOL)omode
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
