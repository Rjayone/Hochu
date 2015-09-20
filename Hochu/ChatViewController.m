//
//  ChatViewController.m
//  Hochu
//
//  Created by Andew Medvedev on 14.09.15.
//  Copyright (c) 2015 Andew Medvedev. All rights reserved.
//

#import "ChatViewController.h"
#import "DialogItem.h"
#import "ChatTableViewCell.h"

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (strong, nonatomic) NSMutableArray* dialogHistory;    //Array of dialog items
//@property (weak, nonatomic) IBOutlet UITextField *messageBox;
@property (weak, nonatomic) IBOutlet UITextView *messageBox;
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomConstraint;

@property (assign, nonatomic) UIEdgeInsets initialInsets;
@property (assign, nonatomic) NSInteger defaultTextViewHeight;
@property (assign, nonatomic) NSInteger dialogId;


@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dialogHistory = [NSMutableArray array];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    //Notifications
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    NAV_ITEM.title = @"Диалог";
    
    self.messageBox.layer.cornerRadius = 5.f;
    self.messageBox.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.messageBox.layer.borderWidth = 0.5;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.defaultTextViewHeight = CGRectGetHeight( self.messageBox.frame);
    [self loadMessageHitoryForDialogId:0];
}


#pragma mark - UITableView DataSource
//--------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//--------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogHistory.count;
}

//--------------------------------------------------------------------
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ChatToCell" forIndexPath:indexPath];
    if(!cell)
        cell = [ChatTableViewCell new];
    DialogItem* item = [self.dialogHistory objectAtIndex:indexPath.row];
    cell.messageLabel.text = item.message;
    return cell;
}


#pragma mark - UITableView Delegate
//--------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 16.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

//---------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

//--------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendMessage:nil];
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.textViewHeight.constant = textView.contentSize.height;
    [self.view layoutIfNeeded];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - IBActions
- (IBAction)sendMessage:(UIButton *)sender {
    if(self.messageBox.text.length == 0)
        return;
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:self.dialogHistory.count inSection:0];
    DialogItem* item = [DialogItem new];
    item.message = self.messageBox.text;
    item.type    = MessageTypeTo;
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dialogHistory addObject:item];
    [self.tableView endUpdates];
    
    if(indexPath.row == 0)
        [self.tableView scrollsToTop];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.messageBox.text = @"";
    self.textViewHeight.constant = self.defaultTextViewHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - Notification
//--------------------------------------------------------------------
- (void)keyboardWillShowNotification:(NSNotification*) params {
    NSDictionary* info = [params userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    self.initialInsets = self.tableView.contentInset;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0.f, kbRect.size.height, 0.f);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    CGFloat animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.inputViewBottomConstraint.constant = kbRect.size.height;
        [self.view layoutIfNeeded];
    }];
    
}

//--------------------------------------------------------------------
- (void)keyboardWillHideNotification:(NSNotification*) params {
    NSDictionary* info = [params userInfo];
    self.tableView.contentInset = self.initialInsets;
    self.tableView.contentOffset = (CGPoint){0, -64};
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    
    CGFloat animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.inputViewBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
    
    if(self.dialogHistory.count > 0) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:self.dialogHistory.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}


#pragma mark - Loaders
- (void)loadMessageHitoryForDialogId:(NSInteger)dialogId {
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:self.dialogHistory.count inSection:0];
    DialogItem* item = [DialogItem new];
    NSString* want = [self.segueParams objectForKey:@"want"];
    User* user = [self.segueParams objectForKey:@"user"];
    item.message = [NSString stringWithFormat:@"Привет, меня зовут %@. Я хочу заказать %@", user.name, want];
    item.type    = MessageTypeTo;
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dialogHistory addObject:item];
    [self.tableView endUpdates];
}

@end
