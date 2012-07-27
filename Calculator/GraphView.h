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
- (float):xValueForGraphView:(GraphView *)sender;
@end


@interface GraphView : UIView
@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat origin;


- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)pan:(UIPanGestureRecognizer *)gesture;
- (void)triple:(UITapGestureRecognizer *)gesture;

/*
@property (nonatomic, weak) IBOutlet id <GraphViewDataSource> dataSource;
 
*/

@end