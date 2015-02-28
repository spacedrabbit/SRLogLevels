//
//  SRDeviceOverviewTableViewController.m
//  SRDeviceLogs
//
//  Created by Tur, Louis on 2/25/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRDeviceOverviewTableViewController.h"
#import "SystemServices.h"

const NSString * kHardware = @"Hardware";
const NSString * kProcessor = @"Processor";
const NSString * kAccessories = @"Accessories";
const NSString * kCarrier = @"Carrier";
const NSString * kBattery = @"Battery";
const NSString * kMemory = @"Memory";
const NSString * kAppInfo = @"App Info";
const NSString * kSSUUID = @"SSUUID";

static NSString * kCellIdentifier = @"cell";

@interface SRDeviceOverviewTableViewController ()

@property (strong, nonatomic) UIFont            * menloFont;

@property (strong, nonatomic) SystemServices    * sharedSystemManager;
@property (strong, nonatomic) NSDictionary      * systemOverview;

@property (strong, nonatomic) NSDictionary      *  selectiveOverviewCategories;
@property (strong, nonatomic) NSDictionary      *  filteredDeviceInfo;

@end

@implementation SRDeviceOverviewTableViewController

#pragma mark - Lazy Loaders
-(SystemServices *)sharedSystemManager{
    if (!_sharedSystemManager) {
        _sharedSystemManager = [SystemServices sharedServices];
    }
    return _sharedSystemManager;
}
-(UIFont *)menloFont{
    if (!_menloFont) {
        _menloFont = [UIFont fontWithName:@"Menlo-Heavy" size:20.0];
    }
    return _menloFont;
}
-(NSDictionary *)selectiveOverviewCategories{
    if (!_selectiveOverviewCategories) {
        _selectiveOverviewCategories =  @{ @"Overview"     : @[ @"DeviceModel", @"DeviceName", @"SystemName",
                                                                @"SystemVersion", @"SystemDeviceType Formatted",
                                                                @"DebuggerAttached", @"Jailbroken", @"UniqueID",
                                                                @"DeviceSignature", @"CFUUID"                      ],
                                           
                                           @"Localization" : @[ @"Country", @"Language", @"TimeZone"               ],
                                           
                                           @"Processor"    : @[ @"NumberProcessors", @"NumberActiveProcessors",
                                                                @"ProcessorSpeed", @"ProcessorBusSpeed"            ],
                                           
                                           @"Storage"      : @[ @"DiskSpace",
                                                                @"FreeDiskSpace (Formatted)",
                                                                @"UsedDiskSpace (Formatted)"                       ],
                                           
                                           @"Memory"       : @[ @"TotalMemory",
                                                                @"FreeMemory (Formatted)",
                                                                @"ActiveMemory (Formatted)",
                                                                @"InactiveMemory (Formatted)",
                                                                @"WiredMemory (Formatted)"                         ],
                                           @"Peripherals"  : @[ @"AccessoriesAttached",
                                                                @"HeadphonesAttached",
                                                                @"NumberAttachedAccessories",
                                                                @"PluggedIn"                                       ],
                                           @"Reachability" : @[ @"CarrierName",
                                                                @"CarrierCountry",
                                                                @"ConnectedToWiFi",
                                                                @"ConnectedToCellNetwork"                          ],
                                           
                                           @"Process SnapShot" : @[@"ProcessesInformation"                         ],
                                           
                                           @"Battery"          : @[@"BatteryLevel", @"Charging", @"FullyCharged"   ]
                                           
                                           };
    }
    return _selectiveOverviewCategories;
}


#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewCell * diagnosticCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    diagnosticCell.textLabel.font = self.menloFont;
    [self.tableView registerClass:[diagnosticCell class] forCellReuseIdentifier:diagnosticCell.reuseIdentifier];
    
    self.systemOverview = [self.sharedSystemManager allSystemInformation];
}

#pragma mark - TABLEVIEW DELEGATE

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    }
    
    NSString * currentCategory = [self.selectiveOverviewCategories allKeys][indexPath.section];
    NSArray * categoryDetails = [self.selectiveOverviewCategories objectForKey:currentCategory];
    id infoToDisplay = categoryDetails[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", infoToDisplay];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.selectiveOverviewCategories allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString * currentCategory = [self.selectiveOverviewCategories allKeys][section];
    NSInteger numberOfDetails = [(NSArray *)self.selectiveOverviewCategories[currentCategory] count];
    
    return numberOfDetails;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.selectiveOverviewCategories allKeys][section];
}

#pragma - Boiler Plate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
