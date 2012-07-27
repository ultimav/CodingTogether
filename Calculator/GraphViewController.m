//
//  GraphViewController.m
//  Calculator
//
//  Created by Dana Cleveland on 7/24/12.
//  Copyright (c) 2012 Scritch.org. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
@interface GraphViewController()
@property (weak, nonatomic) IBOutlet GraphView *graphView;
@end

@implementation GraphViewController
@synthesize origin = _origin;
@synthesize graphView = _graphView;
@synthesize programToGraph = _programToGraph;

- (void)setProgramToGraph:(id)programToGraph
{
    _programToGraph = programToGraph;
    [self.graphView setNeedsDisplay]; // any time our Model changes, redraw our View
}


-(void)setGraphView:(GraphView *)graphView
{
    _graphView = graphView;
    
}


- (float)xValueForGraphView:(GraphView *)sender
{
    return 1.0; //change
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
