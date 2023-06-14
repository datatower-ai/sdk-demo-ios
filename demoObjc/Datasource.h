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
@property (nonatomic) NSArray *items;

+ (NSString *)serverUrl;
+ (NSString *)appId;

@end

NS_ASSUME_NONNULL_END
