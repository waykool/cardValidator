//
//  ViewController.m
//  SimpleCardValidator
//
//  Created by Pedro Peres on 8/9/15.
//  Copyright (c) 2015 Pedro Peres. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UITextField *_textfield;
    UILabel *_creditCardLabel;
    UIButton *_button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK - Settup

- (void) setupView {
    CGRect labelFrame = CGRectMake(10, 20, 120, 45);
    CGFloat textFieldXCoor = labelFrame.size.width + 10;
    CGFloat textFieldWidth = self.view.frame.size.width - textFieldXCoor - 10;
    CGRect textFieldFrame = CGRectMake(textFieldXCoor, 20, textFieldWidth, 45);
    CGRect buttonFrame = CGRectMake(20, 70, 100, 45);
    CGRect creditCardLabelFrame = CGRectMake(140, 70, 100, 45);

    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = @"Card Number: ";
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];

    _textfield = [[UITextField alloc] initWithFrame:textFieldFrame];
    _textfield.placeholder = @"ie. 4217-6989-2345-2345";
    _textfield.backgroundColor = [UIColor lightGrayColor];
    _textfield.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_textfield];

    _button = [[UIButton alloc] initWithFrame:buttonFrame];
    [_button setTitle:@"Submit" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonTappedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];

    _creditCardLabel = [[UILabel alloc] initWithFrame:creditCardLabelFrame];
    label.text = @"Card Number: ";
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];
}

- (void) buttonTappedAction {

}

@end
