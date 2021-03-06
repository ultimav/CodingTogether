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

@interface GraphViewController() <GraphViewDataSource, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet GraphView *graphView;
@property (nonatomic, strong) UIBarButtonItem *splitViewBarButtonItem;
@property (nonatomic, weak) IBOutlet UIToolbar* toolbar;
@end

@implementation GraphViewController
//@synthesize origin = _origin;
@synthesize graphView = _graphView;
@synthesize programToGraph = _programToGraph;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;   // 
@synthesize toolbar = _toolbar;
 
-(void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    if (_splitViewBarButtonItem != splitViewBarButtonItem){
        NSMutableArray *toolbarItems = [ self.toolbar.items mutableCopy];
        if (_splitViewBarButtonItem) [toolbarItems removeObject:splitViewBarButtonItem];
        if (splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
        self.toolbar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}


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
    double yValue = [CaclulatorBrain runProgram:self.programToGraph usingVariableValues:values];
    //NSLog([NSString stringWithFormat:@"x= %g , y= %g"],x,yValue); 
    return (yValue);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (self.splitViewController) {
        return YES;
    } else {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);

    }
}

  
// viewDidLoad is callled after this view controller has been fully instantiated
//  and its outlets have all been hooked up.
- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = self.title;
    self.splitViewBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.splitViewBarButtonItem = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.splitViewController) {
        //[self handleSplitViewBarButtonItem:self.splitViewBarButtonItem];
        self.splitViewController.delegate = self;
    }
    
}
- (void) awakeFromNib
{
    [super awakeFromNib];
    if (self.splitViewController) {
        self.splitViewController.delegate = self;

    }
}
@end
