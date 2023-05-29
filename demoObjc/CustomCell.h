//
//  CustomCell.h
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@interface CustomCell : UITableViewCell

- (void)setModel:(CellViewModel *)vm;

+ (CGFloat)cellHeihgt;

@end

NS_ASSUME_NONNULL_END
