//
//  SRLoggingAdjustmentViewController.m
//  SRDeviceLogs
//
//  Created by Tur, Louis on 2/26/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRLogConfigManager.h"
#import "SRLoggingAdjustmentViewController.h"
#import "UIColor+TubulrColors.h"

#import <CocoaLumberjack/DDLog.h>
#import <objc/runtime.h>

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
}

-(void)createLogLevelButtons{
    
    // -- BUTTONS -- //
    UIButton * noLogsButton = [self createLogButtonForLog:@"No Logs"
                                                    color:[UIColor srl_heartPinkColor]
                                             andAddToView:self.containerView];
    [noLogsButton addTarget:[SRLogConfigManager class] action:@selector(changeToNoLogs)
                                             forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * infoLogsButton = [self createLogButtonForLog:@"Info Logs"
                                                      color:[UIColor srl_hipsterMaroon]
                                               andAddToView:self.containerView];
    [infoLogsButton addTarget:[SRLogConfigManager class] action:@selector(changeToDebugLogs)
                                               forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * verboseLogsButton = [self createLogButtonForLog:@"Verbose Logs"
                                                         color:[UIColor srl_hipsterPeach]
                                                  andAddToView:self.containerView];
    
    UIButton * warningLogsButton = [self createLogButtonForLog:@"Warning Logs"
                                                         color:[UIColor srl_hipsterPistacchio]
                                                  andAddToView:self.containerView];

    UIButton * errorLogsButton = [self createLogButtonForLog:@"Error Logs"
                                                       color:[UIColor srl_hipsterSalmon]
                                                andAddToView:self.containerView];
    
    
    // -- AUTOLAYOUT -- //
    NSDictionary * buttonsDictionary = NSDictionaryOfVariableBindings(noLogsButton, infoLogsButton, verboseLogsButton, warningLogsButton, errorLogsButton);
    
    NSArray * buttonAlignment = @[ [NSLayoutConstraint constraintsWithVisualFormat:
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
    
    
    for (NSArray * constraint in buttonAlignment) {
        [self.view addConstraints:constraint];
    }
    
}

-(UIButton *) createLogButtonForLog:(NSString *)logLevel color:(UIColor *)color andAddToView:(UIView *)parentView{
    
    UIButton * logButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [logButton setBackgroundColor:color];
    [logButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [logButton setTitle:logLevel forState:UIControlStateNormal];
    
    [parentView addSubview:logButton];
    
    return logButton;
}


@end
