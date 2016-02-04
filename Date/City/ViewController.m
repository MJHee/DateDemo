//
//  ViewController.m
//  City
//
//  Created by 贺梦洁 on 16/1/25.
//  Copyright © 2016年 贺梦洁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSLocale *datelocale;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPicker];
}
//初始化PickerView使用的数据源
- (void)initPicker{
    self.dateTextField.tag = 1001;
    self.dateTextField.delegate = self;
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
}
#pragma mark - 监听
- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    self.dateTextField.text = dateString;
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([_dateTextField isFirstResponder])
    {
        // 建立 UIDatePicker
        _datePicker = [[UIDatePicker alloc]init];
        //location设置为中国
        _datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = _datelocale;
        //GMT 就是格林威治标准时间的英文缩写
        _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _dateTextField.inputView = _datePicker;
        
        // 建立 UIToolbar
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(cancelPicker)];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
        toolBar.items = [NSArray arrayWithObjects:space,right,nil];
        _dateTextField.inputAccessoryView = toolBar;
    }
}

#pragma mark - 按钮监听
- (void)cancelPicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _dateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]];
    [_dateTextField resignFirstResponder];
}
@end
