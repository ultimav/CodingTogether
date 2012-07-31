//
//  GraphViewController.h
//  Calculator
//
//  Created by Dana Cleveland on 7/24/12.
//  Copyright (c) 2012 Scritch.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewBarButtonItemPresenter.h"

@interface GraphViewController : UIViewController <SplitViewBarButtonItemPresenter>
@property (nonatomic) id programToGraph;
@property (nonatomic) int origin;    

@end
