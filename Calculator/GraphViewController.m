//
//  GraphViewController.m
//  Calculator
//
//  Created by Dana Cleveland on 7/24/12.
//  Copyright (c) 2012 Scritch.org. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
#import "CaclulatorBrain.h"

@interface GraphViewController() <GraphViewDataSource>
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
    // enable pinch gestures in the GraphView using its pinch: handler
    [self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pinch:)]];
    // recognize a pan gesture and modify our Model
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pan:)]];
    // set tap gesture
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(triple:)];
    //need to tap 3 times!
    tapper.numberOfTapsRequired = 3;
    [self.graphView addGestureRecognizer:tapper];
    self.graphView.dataSource = self;

    
}


 
- (double) graphView:(GraphView *)sender yValueForGraphView: (double) x;
{
     NSDictionary *values = [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:x] forKey:@"x"];
    //change it based on y
    //Add ComputerBrain given X
    //Run the program and return Y
    return ([CaclulatorBrain runProgram:self.programToGraph usingVariableValues:values]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == YES); //UIInterfaceOrientationPortrait);
}

@end
