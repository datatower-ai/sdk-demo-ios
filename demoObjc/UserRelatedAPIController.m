//
//  UserRelatedAPIController.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "UserRelatedAPIController.h"

@interface UserRelatedAPIController ()

@end

@implementation UserRelatedAPIController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIView *closeButton = [[UIView alloc] init];
    closeButton.userInteractionEnabled = YES;
    closeButton.backgroundColor = [UIColor yellowColor];
    closeButton.frame = CGRectMake(50, 50, 30, 20);
    [self.view addSubview:closeButton];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    [closeButton addGestureRecognizer:gesture];
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
