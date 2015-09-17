//
//  ContactViewController.m
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController () <UITextFieldDelegate>

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}

//--------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - UITextField Delegate
//--------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}


#pragma mark - Notification
//--------------------------------------------------------------------
- (void)keyboardWillShowNotification:(NSDictionary*) params {
    
}


#pragma mark - Segue
//--------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
@end
