//
//  UserRelatedAPIController.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "UserRelatedAPIController.h"
#import <DataTowerAICore/DTAnalytics.h>
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

const CGFloat leftX = 25;
#define controlWidth  ([UIScreen mainScreen].bounds.size.width - leftX * 2)
#define alignTop(topView, nextView, height)  nextView.frame = CGRectMake(leftX, CGRectGetMinY(topView.frame) + CGRectGetHeight(topView.frame) + 10, controlWidth, height);

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface MethoInfo : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *params;
@end
@implementation MethoInfo
@end

@interface UserRelatedAPIController ()
@property (nonatomic) UILabel *textFieldDesp;
@property (nonatomic) UITextField *textField;
@property (nonatomic) UILabel *paramFieldDesp;
@property (nonatomic) UILabel *paramsDescription;
@property (nonatomic) UILabel *inputFieldDesp;
@property (nonatomic) UITextField *inputParsm;
@property (nonatomic) UIPickerView *picker;
@property (nonatomic) NSMutableArray<MethoInfo *> *pickerArray;
@property (nonatomic) UIButton *confirmBtn;
@property (nonatomic) UIButton *closeBtn;
@property (nonatomic) UIView *cancelInputView;

@end

@implementation UserRelatedAPIController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"User Rellated API"];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.cancelInputView];
    [self.cancelInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.textField.inputView = self.picker;
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.paramsDescription];
    [self.view addSubview:self.inputParsm];
    [self.view addSubview:self.textFieldDesp];
    [self.view addSubview:self.paramFieldDesp];
    [self.view addSubview:self.inputFieldDesp];
    [self.view addSubview:self.closeBtn];
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

- (void)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
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
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        
        alignTop( self.textFieldDesp, _textField, 30);
        
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.textAlignment = UITextAlignmentCenter;
        _textField.delegate = self;
        [_textField setTextColor:[UIColor blueColor]];
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
        _paramsDescription.backgroundColor = [UIColor lightGrayColor];

        alignTop(self.paramFieldDesp, _paramsDescription, 50);
    }
    
    return _paramsDescription;
}

- (UITextField *)inputParsm {
    if (!_inputParsm) {
        _inputParsm = [[UITextField alloc] init];
        
        alignTop(self.inputFieldDesp, _inputParsm, 200);

        _inputParsm.backgroundColor = [UIColor lightGrayColor];
    }
    return _inputParsm;
}

- (UILabel *)textFieldDesp {
    if (!_textFieldDesp) {
        _textFieldDesp = [[UILabel alloc] init];
        _textFieldDesp.frame = CGRectMake(leftX, 50, controlWidth, 20);
        _textFieldDesp.text = @"Select API to invoke:";
    }
    return _textFieldDesp;
}

- (UILabel *)paramFieldDesp {
    if (!_paramFieldDesp) {
        _paramFieldDesp = [[UILabel alloc] init];
        _paramFieldDesp.text = @"The param format is";
        alignTop(self.textField, _paramFieldDesp, 20);
    }
    return _paramFieldDesp;
}

- (UILabel *)inputFieldDesp {
    if (!_inputFieldDesp) {
        _inputFieldDesp = [[UILabel alloc] init];
        alignTop(self.paramsDescription, _inputFieldDesp, 20);
        _inputFieldDesp.text = @"Input param with json format:";
    }
    return _inputFieldDesp;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        _confirmBtn.frame = CGRectMake(leftX, screenHeight - 50 - 200, controlWidth, 50);
        _confirmBtn.layer.cornerRadius = 10;
        [_confirmBtn setTitle:@"Invoke" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor blueColor];
        [_confirmBtn addTarget:self action:@selector(invokeMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"Res/closeBtn"] forState:UIControlStateNormal];
        _closeBtn.frame = CGRectMake(screenWidth - leftX - 30, leftX, 30, 30);
        [_closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIView *)cancelInputView {
    if (!_cancelInputView) {
        _cancelInputView = [[UIView alloc] init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
        
        [_cancelInputView addGestureRecognizer:tap];
    }
    
    return _cancelInputView;
}

@end



