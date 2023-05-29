//
//  CellViewModel.h
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^onTapCell)(void);
typedef NSString*(^getContent)(void);

@interface CellViewModel : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *content;

@property (nonatomic, copy) getContent getContent;
@property (nonatomic, copy) onTapCell tapAction;

- (instancetype)initWith:(NSString *)title content:(NSString *)content tapAction:(onTapCell)action;

- (instancetype)initWith:(NSString *)title getContent:(getContent)block tapAction:(onTapCell)action;

@end

NS_ASSUME_NONNULL_END
