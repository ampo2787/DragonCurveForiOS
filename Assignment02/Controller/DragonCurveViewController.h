//
//  DragonCurveViewController.h
//  Assignment02
//
//  Created by JihoonPark on 12/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragonView.h"

@interface DragonCurveViewController : UIViewController <DragonViewDelegate>

@property (weak, nonatomic) IBOutlet DragonView *dragonView;
@property (weak, nonatomic) IBOutlet UIView *stepControlView;


@property (weak, nonatomic) IBOutlet UITextField *dragonOrderField;
- (IBAction)dragonOrderFieldChange:(UITextField *)sender;



@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)segChanged:(UISegmentedControl *)sender;


@property (weak, nonatomic) IBOutlet UIButton *stepButton;
- (IBAction)stepButtonTouched:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
- (IBAction)stopButtonTouched:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISlider *stepSizeSlider;


@end
