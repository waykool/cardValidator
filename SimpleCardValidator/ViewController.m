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
    CGRect labelFrame = CGRectMake(10, 70, 120, 45);
    CGFloat textFieldXCoor = labelFrame.size.width + 10;
    CGFloat textFieldWidth = self.view.frame.size.width - textFieldXCoor - 10;
    CGRect textFieldFrame = CGRectMake(textFieldXCoor, 70, textFieldWidth, 45);
    CGRect buttonFrame = CGRectMake(20, 120, 100, 45);
    CGRect creditCardLabelFrame = CGRectMake(140, 20, 300, 45);

    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = @"Card Number: ";
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];

    _textfield = [[UITextField alloc] initWithFrame:textFieldFrame];
    _textfield.placeholder = @"ie. 4217-6989-2345-2345";
    _textfield.backgroundColor = [UIColor lightGrayColor];
    _textfield.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    _textfield.delegate = self;
    [self.view addSubview:_textfield];

    _button = [[UIButton alloc] initWithFrame:buttonFrame];
    [_button setTitle:@"Submit" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonTappedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];

    _creditCardLabel = [[UILabel alloc] initWithFrame:creditCardLabelFrame];
    [self.view addSubview:_creditCardLabel];
    _creditCardLabel.textColor = [UIColor whiteColor];
}

// MARK - Actions

- (void) buttonTappedAction {
    BOOL isCardValid = [self validateCard];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message: [self alertMessage:isCardValid]
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// MARK - UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(_textfield.text.length > 0) {
        NSString *firstNumber = [NSString stringWithFormat:@"%C", [_textfield.text characterAtIndex:0]];

        if([firstNumber  isEqual: @"4"]){
            _creditCardLabel.text = @"VISA";

        } else if([firstNumber  isEqual: @"5"]) {
            _creditCardLabel.text = @"MASTER CARD";

        } else if([firstNumber  isEqual: @"3"]) {
            _creditCardLabel.text = @"AMERICAN EXPRESS";

        } else if([firstNumber  isEqual: @"6"]) {
            _creditCardLabel.text = @"DISCOVER";

        } else {
            _creditCardLabel.text = @"";

        }
    }

    if([self isAllDigits: string]){
        return true;
    } else {
        return false;
    }
}

// MARK - Service Mehtods

- (BOOL) isAllDigits:(NSString *) string {
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [string rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

-(NSString *) alertMessage:(BOOL) isCardValid {
    if (isCardValid) {
        return @"Card number is valid!";

    } else {
        return @"Card number is not valid!";
    }
}

/*
 calculating doubles for the Luhn algorithm
 - if result has only one digit we leave it alone
 - if result has 2 digits we add the digits
 - ie. if double = 12 then result = 3

 - in order not to have to split numbers we apply
 the formula d = 1 + (2*(x-5)) for numbers greater than 5.
 */
- (BOOL) validateCard {
    NSArray *numberArray = [self getArrayOfNumbersFromString: _textfield.text];
    NSInteger total = 0;

    for(int i = 0; i < numberArray.count; i++){
        NSInteger currentNumber = [numberArray[i] integerValue];

        if((i % 2) != 0) {
            if(currentNumber < 5) {
                total += 2 * currentNumber;

            } else {
                total += 1 + (2 * (currentNumber - 5));
            }
        } else {
            total += currentNumber;
        }
    }

    return ((total%10) == 0);
}

/*
 take a string and iterate through chrarcters
 if character is a digit add it to the array
 */
- (NSArray *) getArrayOfNumbersFromString:(NSString *) string {
    NSMutableArray *numberArray = [[NSMutableArray alloc] init];
    NSString *cardNumberString = _textfield.text;
    NSString *numberString;

    for(int i = (int) (cardNumberString.length - 1); i >= 0; i--){
        numberString = [NSString stringWithFormat:@"%C", [cardNumberString characterAtIndex:i]];
        NSInteger integerValue = [numberString integerValue];
        [numberArray addObject:[[NSNumber alloc] initWithInteger: integerValue]];
    }
    
    return numberArray;
}

@end
