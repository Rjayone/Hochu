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
@property (weak, nonatomic) IBOutlet UIButton* continueButton;
@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.continueButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.01f];
    self.continueButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.continueButton.layer.borderWidth = 4;
    self.continueButton.layer.cornerRadius = 10;
}


@end
