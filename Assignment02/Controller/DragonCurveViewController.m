//
//  DragonCurveViewController.m
//  Assignment02
//
//  Created by JihoonPark on 12/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "DragonCurveViewController.h"
#import "DragonView.h"
#import "DragonCurve.h"

#pragma mark - Constants

#define DEFAULT_DRAGON_ORDER    2
#define MIN_DRAGON_ORDER        1

#pragma mark - Declaration of private Properties & Methods
@interface DragonCurveViewController ()

#pragma mark - Private Properties
@property (assign) int order;
@property (assign) BOOL singleDrwaing;
@property (assign) BOOL stepByStepDrawingEnabled;
@property (assign) int stepPathLength;

@property (nonatomic) DragonCurve* dragonCurve;
@property (nonatomic) NSArray * dragonPath;

#pragma mark - Private Methods
-(void) updateUI;
-(void) setTitleForStepButton;
-(void) setTitleForStopButton;
-(void) initStepControlAndView;
-(int) stepOrder;

@end

#pragma mark - Implementation
@implementation DragonCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dragonView setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.singleDrwaing = TRUE;
    [self.segmentControl setSelectedSegmentIndex:0];
    
    [self initStepControlAndView];
    
    self.order = DEFAULT_DRAGON_ORDER;
    self.dragonPath = [self.dragonCurve dragonPath:self.order];
    [self updateUI];
}

#pragma mark - Tap Gesture
-(void)dismissKeyboard{
    [self.dragonOrderField resignFirstResponder];
}

#pragma mark - Private Methods
-(DragonCurve *) dragonCurve{
    if(_dragonCurve == nil){
        _dragonCurve = [[DragonCurve alloc]init];
    }
    return _dragonCurve;
}

-(void) updateUI {
    [self.dragonView setNeedsDisplay];
    [self.stepControlView setNeedsDisplay];
    [self.segmentControl setNeedsDisplay];
}

-(void)setTitleForStepButton{
    UIColor *titleColor = [UIColor brownColor];
    NSMutableAttributedString* titleForStepButton = [[NSMutableAttributedString alloc]initWithAttributedString:[self.stepButton currentAttributedTitle]];
    NSRange titleRange = NSMakeRange(0, titleForStepButton.length);
    [titleForStepButton addAttribute:NSForegroundColorAttributeName value:titleColor range:titleRange];
    [self.stepButton setAttributedTitle:titleForStepButton forState:UIControlStateNormal];
}

-(void)setTitleForStopButton{
    UIColor *titleColor = [UIColor brownColor];
    NSMutableAttributedString* titleForStopButton = [[NSMutableAttributedString alloc]initWithAttributedString:[self.stopButton currentAttributedTitle]];
    NSRange titleRange = NSMakeRange(0, titleForStopButton.length);
    [titleForStopButton addAttribute:NSForegroundColorAttributeName value:titleColor range:titleRange];
    [titleForStopButton addAttribute:NSFontAttributeName value:[NSNumber numberWithFloat:30.0] range:titleRange];
    [self.stopButton setAttributedTitle:titleForStopButton forState:UIControlStateNormal];
}

- (void)initStepControlAndView{
    self.stepByStepDrawingEnabled = FALSE;
    [self.stepControlView.layer setBackgroundColor:UIColor.lightGrayColor.CGColor];
    [self.stepControlView setHidden:FALSE];
    
    [self setTitleForStepButton];
    [self setTitleForStopButton];
    [self.stepSizeSlider setValue:100];
}

-(int)stepOrder{
    return (int)((double)(self.order-1) * (self.stepSizeSlider.value - self.stepSizeSlider.minimumValue) / (self.stepSizeSlider.maximumValue - self.stepSizeSlider.minimumValue));
}

#pragma mark - Action

- (IBAction)dragonOrderFieldChange:(UITextField *)sender {
    if([sender.text intValue] >= MIN_DRAGON_ORDER){
        self.order = [sender.text intValue];
    }
    else{
        self.order = DEFAULT_DRAGON_ORDER;
    }
    if(self.singleDrwaing){
        self.stepByStepDrawingEnabled = FALSE;
    }
    self.dragonPath = [self.dragonCurve dragonPath:self.order];
    [self updateUI];
}

- (IBAction)segChanged:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0){
        self.singleDrwaing = TRUE;
        self.stepByStepDrawingEnabled = FALSE;
        [self.stepControlView setHidden:FALSE];
    }
    else if(sender.selectedSegmentIndex == 1){
        self.singleDrwaing = FALSE;
        self.stepByStepDrawingEnabled = FALSE;
        [self.stepControlView setHidden:TRUE];
    }
    [self updateUI];

}

- (IBAction)stepButtonTouched:(UIButton *)sender {
    if(!self.stepByStepDrawingEnabled){
        self.stepByStepDrawingEnabled = TRUE;
        self.stepPathLength = (int) pow(2.0, self.stepOrder);
    }else{
        if(self.stepPathLength < (int)self.dragonPath.count){
            self.stepPathLength += (int) pow(2.0, self.stepOrder);
            if(self.stepPathLength > (int)self.dragonPath.count){
                self.stepPathLength = (int)self.dragonPath.count;
            }
        }
        else{
            self.stepPathLength = 0;
        }
    }
    [self updateUI];
}
- (IBAction)stopButtonTouched:(UIButton *)sender {
    self.stepByStepDrawingEnabled = FALSE;
    [self updateUI];
}

#pragma mark - DragonViewDelegate
-(int) dragonOrder: (DragonView*) requestor{
    return self.order;
}

-(NSArray *) dragonPath: (DragonView*) requestor{
    return self.dragonPath;
}

-(BOOL) stepByStepDrawingEnabled:(DragonView *)requester{
    return self.stepByStepDrawingEnabled;
}

-(int)stepPathLength:(DragonView*)requester{
    return self.stepPathLength;
}

- (BOOL)singleDrawing:(nonnull DragonView *)requester {
    return self.singleDrwaing;
}

@end
