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

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray* dialogHistory;    //Array of dialog items
@property (weak, nonatomic) IBOutlet UITextField *messageBox;
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dialogHistory = [NSMutableArray array];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}


#pragma mark - UITextField DataSource
//--------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//--------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogHistory.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ChatToCell" forIndexPath:indexPath];
    if(!cell)
        cell = [ChatTableViewCell new];
    DialogItem* item = [self.dialogHistory objectAtIndex:indexPath.row];
    cell.messageLabel.text = item.message;
    return cell;
}

- (IBAction)sendMessage:(UIButton *)sender {
    DialogItem* item = [DialogItem new];
    item.message = self.messageBox.text;
    item.type    = MessageTypeTo;
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.dialogHistory.count inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dialogHistory addObject:item];
    [self.tableView endUpdates];
}
@end
