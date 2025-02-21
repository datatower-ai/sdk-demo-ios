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
#import "ThirdpartApiViewController.h"

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


- (instancetype)init {
    if(self = [super init]) {
        [self prepareData];
    }
    
    return self;
}

- (void)prepareData {
    
    self.items = @[
     
        makeViewModel2(@"isDebug",^{return [NSString stringWithFormat:@"%d", [self isDebug]];},^{}),
        makeViewModel(@"AppId", [self appId], nil),
        makeViewModel(@"ServerUrl", [self serverUrl], nil),
        makeViewModel2(@"Get DTID",^{return self.dtIdDesp;},^{[self getDTID];}),
        makeViewModel2(@"Get DB items", ^{return [NSString stringWithFormat:@"DB Item Count=%ld", (long)[self dbCount]];}, ^{ [self notify];}),
        makeViewModel(@"Track event 'dt_track_simple",@"Track an event with name of 'dt_track_simple' and properties of a predefined key-value paris",^{[self trackSimpleEvent];}),
        makeViewModel(@"Track event",@"You'll have to fill in the name of the event and its properties",^{ [self openTrackEventViewController];}),
        makeViewModel(@"User related API",@"You'll have to fill in the name of the user api and its params",^{ [self openUserRelatedAPIController];}),
        makeViewModel(@"Third part API",@"firebase id set api etc",^{ [self openThirdpartyApiPage];}),
        makeViewModel(@"SDK Full API",@"check all api",^{ [self openFullApiPage];}),

    ];
}

- (void)notify {
    if(self.action) {
        self.action();
    }
}

- (void)getDTID {
    NSString *dtId = [DTAnalytics getDataTowerId];
    self.dtIdDesp = [NSString stringWithFormat:@"DTID = %@", dtId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self notify];
    });
}

- (NSInteger)dbCount {
    NSInteger ret = 0;
    Class cls = NSClassFromString(@"DTEventTracker");
    SEL selector = NSSelectorFromString(@"getDBCount");

    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                [cls methodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:cls];
    [invocation invoke];
    [invocation getReturnValue:&ret];
    
    return ret;
}

- (void)trackSimpleEvent {    
    NSDictionary *properties1 = @{
        @"product_name":@"商品名",
    };
    [DTAnalytics trackEventName:@"dt_track_simple" properties:properties1];
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

- (void)openThirdpartyApiPage {
    ThirdpartApiViewController *vc = [[ThirdpartApiViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}
                      
@end
