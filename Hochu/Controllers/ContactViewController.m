//
//  ContactViewController.m
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "ContactViewController.h"
#import "ServiceLayer.h"

@interface ContactViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;
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
    return YES;
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
    User* user = [[User alloc] init];
    user.phoneNumber = @"+37529141236";
    user.address = @"Shabanchiki";
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
