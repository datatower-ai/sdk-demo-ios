//
//  AppDelegate.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "AppDelegate.h"
#import <DataTowerAICore/DT.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *appid = @"dt_461a208fdd075c27";
    NSString *serverUrl = @"https://report-inner.roiquery.com";
//        let serverUrl = "https://test.roiquery.com"
//        let serverUrl = "https://report.roiquery.com"
    DTChannel channel  = DTChannelAppStore;
    DTLoggingLevel logLevel  = DTLoggingLevelDebug;
    [DT initSDK:appid serverUrl:serverUrl channel:channel isDebug:YES logLevel:logLevel];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
