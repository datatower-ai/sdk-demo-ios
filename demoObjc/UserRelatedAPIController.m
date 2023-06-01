//
//  UserRelatedAPIController.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "UserRelatedAPIController.h"
#import <DataTowerAICore/DTAnalytics.h>
#import <objc/runtime.h>


@interface MethoInfo : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *params;
@end
@implementation MethoInfo
@end

@interface UserRelatedAPIController ()

@property (nonatomic) UITextField *textField;
@property (nonatomic) UILabel *paramsDescription;
@property (nonatomic) UITextField *inputParsm;
@property (nonatomic) UIPickerView *picker;
@property (nonatomic) NSMutableArray<MethoInfo *> *pickerArray;

@end

@implementation UserRelatedAPIController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIButton *closeButton = [[UIButton alloc] init];
    closeButton.backgroundColor = [UIColor yellowColor];
    closeButton.frame = CGRectMake(50, 50, 30, 20);
    [self.view addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    [self.view addSubview:self.textField];
    self.textField.inputView = self.picker;
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    confirmBtn.frame = CGRectMake(0, screenHeight - 50 - 200, screenWidth, 50);
    [confirmBtn setTitle:@"Run" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor blueColor];
    [confirmBtn addTarget:self action:@selector(invokeMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    [self.view addSubview:self.paramsDescription];
    [self.view addSubview:self.inputParsm];
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)invokeMethod:(id)sender {
    NSString *method = self.textField.text;
//    NSString *jsonStr = @"{\"2\":\"3\"}";
    NSString *jsonStr = self.inputParsm.text;
    if (jsonStr.length == 0)
        return;
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    
    SEL selector = NSSelectorFromString(method);
    
    NSError *jsonError;
    NSData *objectData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:objectData
                                          options:NSJSONReadingMutableContainers
                                            error:&jsonError];
    if (jsonError) {
        return;
    }
    [[DTAnalytics class] performSelector:selector withObject:jsonDict];
}

- (void)done:(id)sender {
    [self.textField endEditing:YES];
}

#pragma mark - Text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
//        [self dateChanged:nil];
    }
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
 numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
 (NSInteger)row inComponent:(NSInteger)component{
    [self.textField setText:[self.pickerArray objectAtIndex:row].name];
    self.paramsDescription.text = [self.pickerArray objectAtIndex:row].params;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
  (NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row].name;
}

#pragma Getter

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:
            CGRectMake(10, 100, 300, 30)];
        
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.textAlignment = UITextAlignmentCenter;
        _textField.delegate = self;
        
        [_textField setPlaceholder:@"Pick a Sport"];
        
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                       target:self action:@selector(done:)];
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                              CGRectMake(0, self.view.frame.size.height-
                                         self.picker.frame.size.height-50, 320, 50)];
        [toolBar setBarStyle:UIBarStyleBlackOpaque];
        NSArray *toolbarItems = [NSArray arrayWithObjects:
                                 doneButton, nil];
        [toolBar setItems:toolbarItems];
        _textField.inputAccessoryView = toolBar;
    }
    
    return _textField;
}

- (UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc]init];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.showsSelectionIndicator = YES;
    }
    
    return _picker;
}

- (NSMutableArray *)pickerArray {
    if (!_pickerArray) {
        _pickerArray = [NSMutableArray array];
        
        unsigned int outCount;
        Method *methodList = class_copyMethodList(object_getClass([DTAnalytics class]), &outCount);
        for (uint i = 0; i < outCount; ++i) {
            SEL name = method_getName(methodList[i]);
            NSString *funcName = NSStringFromSelector(name);
            if ([funcName hasPrefix:@"user"]) {
                MethoInfo *info = [[MethoInfo alloc] init];
                info.name = funcName;
                
                struct objc_method_description *desp = method_getDescription(methodList[i]);
                if (desp) {
                    NSString *tempDesp = [NSString stringWithUTF8String: desp->types];
                    if ([tempDesp rangeOfString: @":8"].location != tempDesp.length - 2) {
                        info.params = @"have param";
                    }
                }
                
                [_pickerArray addObject:info];
            }
        }
    }
    
    return _pickerArray;
}

- (UILabel *)paramsDescription {
    if (!_paramsDescription) {
        _paramsDescription = [[UILabel alloc] init];
        
        CGRect rect = self.textField.frame;
        _paramsDescription.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + CGRectGetHeight(rect) + 5, CGRectGetWidth(rect), 50);
    }
    
    return _paramsDescription;
}

- (UITextField *)inputParsm {
    if (!_inputParsm) {
        _inputParsm = [[UITextField alloc] init];
        
        CGRect rect = self.paramsDescription.frame;
        _inputParsm.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + CGRectGetHeight(rect) + 5, CGRectGetWidth(rect), 100);
        
        _inputParsm.backgroundColor = [UIColor lightGrayColor];
    }
    return _inputParsm;
}

@end



