//
//  MainViewController.m
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "MainViewController.h"
#import "ContactViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) UIButton* continueButton;
@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.continueButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.continueButton.layer.borderWidth = 10.f;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


@end
