//
//  Datasource.h
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^didLoadData)(void);

@interface Datasource : NSObject

@property (nonatomic) didLoadData action;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString* serverUrl;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic) BOOL isDebug;

- (void)prepareData;

@end

NS_ASSUME_NONNULL_END
