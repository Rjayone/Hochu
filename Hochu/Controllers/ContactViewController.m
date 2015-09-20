//
//  ContactViewController.m
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "ContactViewController.h"
#import "ServiceLayer.h"
#import "ChatViewController.h"

@interface ContactViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;
@property (weak, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *iWantTextField;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;


@property (strong, nonatomic) UITextField* activeField;
@property (assign, nonatomic) UIEdgeInsets initialInsets;
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    //Notifications
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    NAV_ITEM.title = @"Контактные данные";
    NAV_ITEM.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    NAV_VC.navigationBar.tintColor = [UIColor whiteColor];
    NAV_VC.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                                  NSFontAttributeName : [UIFont fontWithName:@"ArialMT" size:16.0] };
    
//    self.continueButton.layer.borderColor = [[UIColor redColor]CGColor];
//    self.continueButton.layer.borderWidth = 4;
//    self.continueButton.layer.cornerRadius = 10;
}

//--------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//--------------------------------------------------------------------
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



#pragma mark - UITextField Delegate
//--------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == 5) {
        [self.view endEditing:YES];
        return YES;
    }
    
    for(UIView* view in ((UIView*)[self.scrollView.subviews firstObject]).subviews)
        if(view.tag == textField.tag+1)
            [view becomeFirstResponder];
    return NO;
}


#pragma mark - Notification
//--------------------------------------------------------------------
- (void)keyboardWillShowNotification:(NSNotification*) params {
    NSDictionary* info = [params userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    self.initialInsets = self.scrollView.contentInset;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.f, kbRect.size.height, 0.f);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

//--------------------------------------------------------------------
- (void)keyboardWillHideNotification:(NSNotification*) params {
    self.scrollView.contentInset = self.initialInsets;
    self.scrollView.contentOffset = (CGPoint){0, -64};
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

#pragma mark - Segue
//--------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ChatViewController* chatVC = segue.destinationViewController;
    user = [[User alloc] init];
    user.name = self.clientNameTextField.text;
    user.phoneNumber = self.phoneNumberTextFiled.text;
    user.address = self.addressTextField.text;
    
    NSDictionary* params = @{@"user" : user,
                             @"want" : self.iWantTextField.text
                             };
    
    chatVC.segueParams = params;
    
    [[ServiceLayer sharedService]
        openNewDialogForUser:user
        address:user.address
        withSuccess:^(NSInteger dialogId) {
         //
        } failuer:^(NSError *error, NSInteger statusCode) {
         //code
    }];
    
    
}
@end
