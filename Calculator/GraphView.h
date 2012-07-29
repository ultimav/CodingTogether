//
//  GraphView.h
//  Calculator
//
//  Created by Dana Cleveland on 7/24/12.
//  Copyright (c) 2012 Scritch.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;

@protocol GraphViewDataSource
- (double) graphView:(GraphView *)sender yValueForGraphView: (double) x;
@end


@interface GraphView : UIView
@property (nonatomic) CGFloat scale;
@property (nonatomic) CGPoint origin;


@property (nonatomic, weak) IBOutlet id <GraphViewDataSource> dataSource;

@end