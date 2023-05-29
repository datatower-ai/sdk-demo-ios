//
//  CustomCell.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "CustomCell.h"
#import "CellViewModel.h"

@interface CustomCell ()

@property (nonatomic) UILabel *title;
@property (nonatomic) UILabel *body;
@property (nonatomic) CellViewModel *vm;

@end

@implementation CustomCell

+ (CGFloat)cellHeihgt {
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    
    return self;
}

- (void)createView {
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.body];
}

- (void)setModel:(CellViewModel *)vm {
    self.vm = vm;
    
    [self.title setText:self.vm.title];
    if(self.vm.getContent) {
        [self.body setText:self.vm.getContent()];
    } else {
        [self.body setText:self.vm.content];
    }
    
    [self.title sizeToFit];
    [self.body sizeToFit];
}

#pragma Getter

- (UILabel *)title {
    if(!_title) {
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(10, 10, 20, 20);
        [_title setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    }
    return _title;
}

- (UILabel *)body {
    if(!_body) {
        _body = [[UILabel alloc] init];
        _body.frame = CGRectMake(10, 20 + 10, 50, 50);
        [_body setFont:[UIFont fontWithName:@"Arial" size:14]];
    }
    return _body;
}

@end
