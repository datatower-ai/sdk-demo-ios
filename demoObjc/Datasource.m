//
//  Datasource.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "Datasource.h"
#import "CellViewModel.h"
#import "UserRelatedAPIController.h"
#import "TrackEventViewController.h"
#import <DataTowerAICore/DTAnalytics.h>
#import "FullApiViewController.h"


CellViewModel *makeViewModel(NSString *a, NSString *b, onTapCell c) {
    CellViewModel *ret = [[CellViewModel alloc] initWith:a content:b tapAction:c];
    return ret;
}

CellViewModel *makeViewModel2(NSString *a, getContent b, onTapCell c) {
    CellViewModel *ret = [[CellViewModel alloc] initWith:a getContent:b tapAction:c];
    return ret;
}

@interface Datasource ()

//@property (nonatomic, readwrite) NSMutableArray *datas;
@property (nonatomic) NSString *dtIdDesp;

@end

@implementation Datasource

+ (NSString *)serverUrl {
//    NSString *serverUrl = @"https://report-inner.roiquery.com";
    static NSString *serverUrl = @"https://test.roiquery.com";
//        NSString * serverUrl = @"https://report.roiquery.com";
    
    return serverUrl;
}

+ (NSString *)appId {
    
// Override point for customization after application launch.
    static NSString *appid = @"dt_461a208fdd075c27";
//    NSString *appid = @"dt_beb231f90a5a20ba";

    return appid;
}

- (instancetype)init {
    if(self = [super init]) {
        [self prepareData];
    }
    
    return self;
}

- (void)prepareData {
    
    self.items = @[
     
        makeViewModel2(@"isDebug",^{return [NSString stringWithFormat:@"%@", [self isDebug]];},^{}),
        makeViewModel(@"AppId", [self.class appId], nil),
        makeViewModel(@"ServerUrl", [self.class serverUrl], nil),
        makeViewModel2(@"Get DTID",^{return self.dtIdDesp;},^{[self getDTID];}),
        makeViewModel2(@"Get DB items", ^{return [NSString stringWithFormat:@"DB Item Count=%d", [self dbCount]];}, ^{ [self notify];}),
        makeViewModel(@"Track event 'dt_track_simple",@"Track an event with name of 'dt_track_simple' and properties of a predefined key-value paris",^{}),
        makeViewModel(@"Track event",@"You'll have to fill in the name of the event and its properties",^{ [self openTrackEventViewController];}),
        makeViewModel(@"User related API",@"You'll have to fill in the name of the user api and its params",^{ [self openUserRelatedAPIController];}),
        makeViewModel(@"SDK Full API",@"check all api",^{ [self openFullApiPage];}),
    ];
}

- (void)notify {
    if(self.action) {
        self.action();
    }
}

- (NSString *)isDebug {
#ifdef DEBUG
    return @"1";
#endif
    return @"0";
}

- (void)getDTID {
    NSString *dtId = [DTAnalytics getDataTowerId];
    self.dtIdDesp = [NSString stringWithFormat:@"DTID = %@", dtId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self notify];
    });
}

- (int)dbCount {
    return 0;
}

- (void)openTrackEventViewController {
    TrackEventViewController *vc = [[TrackEventViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)openUserRelatedAPIController {
    UserRelatedAPIController *vc = [[UserRelatedAPIController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)openFullApiPage {
    FullApiViewController *vc = [[FullApiViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}
                      
@end
