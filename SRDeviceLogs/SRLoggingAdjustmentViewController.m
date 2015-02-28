//
//  SRLoggingAdjustmentViewController.m
//  SRDeviceLogs
//
//  Created by Tur, Louis on 2/26/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRLoggingAdjustmentViewController.h"
#import "UIColor+TubulrColors.h"

#import <CocoaLumberjack/DDLog.h>

@interface SRLoggingAdjustmentViewController ()

@property (strong, nonatomic) UIView * containerView;

@end

@implementation SRLoggingAdjustmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone; // adjusts the view controller's view to start at the navbar
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.containerView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createLogLevelButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createLogLevelButtons{
    
    UIButton * noLogsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [noLogsButton setBackgroundColor:[UIColor srl_heartPinkColor]];
    [noLogsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [noLogsButton setTitle:@"No Logs" forState:UIControlStateNormal];
    
    UIButton * infoLogsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [infoLogsButton setBackgroundColor:[UIColor srl_linkNormalOrangeColor]];
    [infoLogsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [infoLogsButton setTitle:@"Info Logs" forState:UIControlStateNormal];
    
    UIButton * verboseLogsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [verboseLogsButton setBackgroundColor:[UIColor srl_watchBlueColor]];
    [verboseLogsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [verboseLogsButton setTitle:@"Verbose Logs" forState:UIControlStateNormal];
    
    UIButton * warningLogsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [warningLogsButton setBackgroundColor:[UIColor srl_linkHoverBrownColor]];
    [warningLogsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [warningLogsButton setTitle:@"Warning Logs" forState:UIControlStateNormal];
    
    UIButton * errorLogsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [errorLogsButton setBackgroundColor:[UIColor srl_addVideoGrayColor]];
    [errorLogsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [errorLogsButton setTitle:@"Error Logs" forState:UIControlStateNormal];
    
    [self.containerView addSubview:noLogsButton];
    [self.containerView addSubview:infoLogsButton];
    [self.containerView addSubview:verboseLogsButton];
    [self.containerView addSubview:warningLogsButton];
    [self.containerView addSubview:errorLogsButton];
    
    NSDictionary * buttonsDictionary = NSDictionaryOfVariableBindings(noLogsButton, infoLogsButton, verboseLogsButton, warningLogsButton, errorLogsButton);
    
    NSArray * verticalButtonAlignment = @[ [NSLayoutConstraint constraintsWithVisualFormat:
                                            @"V:|-[noLogsButton]-[infoLogsButton]-[verboseLogsButton]-[warningLogsButton]-[errorLogsButton]"
                                                                                   options:NSLayoutFormatAlignAllCenterX|NSLayoutFormatAlignAllLeading
                                                                                   metrics:nil
                                                                                     views:buttonsDictionary],
                                           [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[noLogsButton]-|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:buttonsDictionary],
                                           [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[container]|"
                                                                                   options:NSLayoutFormatAlignAllTop
                                                                                   metrics:nil
                                                                                     views:@{@"container":self.containerView}],
                                           [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[container]|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:@{@"container":self.containerView}]
                                           ];
    
    
    for (NSArray * constraint in verticalButtonAlignment) {
        [self.view addConstraints:constraint];
    }
    
}

@end
