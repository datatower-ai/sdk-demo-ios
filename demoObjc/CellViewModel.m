//
//  CellViewModel.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "CellViewModel.h"

@implementation CellViewModel


- (instancetype)initWith:(NSString *)title content:(NSString *)content tapAction:(onTapCell)action {
    
    if(self = [super init]) {
        self.title = title;
        self.content = content;
        self.tapAction = action;
    }
    
    return self;
    
}

- (instancetype)initWith:(NSString *)title getContent:(getContent)block tapAction:(onTapCell)action {
    
    if(self = [super init]) {
        self.title = title;
        self.getContent = block;
        self.tapAction = action;
    }
    
    return self;
}

@end
