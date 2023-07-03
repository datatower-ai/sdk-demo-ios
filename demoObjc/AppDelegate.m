//
//  AppDelegate.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "AppDelegate.h"
#import <DataTowerAICore/DT.h>
#import "Datasource.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    DTChannel channel  = DTChannelAppStore;
    DTLoggingLevel logLevel  = DTLoggingLevelDebug;
    [DT initSDK:[Datasource appId] serverUrl:[Datasource serverUrl] channel:channel isDebug:[Datasource isDebug] logLevel:logLevel];
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
