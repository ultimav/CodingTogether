//
//  CaclulatorViewController.h
//  Calculator
//
//  Created by Dana Cleveland on 7/13/12.
//  Copyright (c) 2012 Scritchy.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaclulatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (strong, nonatomic) IBOutlet UILabel *history;
@property (strong, nonatomic) IBOutlet UILabel *displayVariables;

@end
