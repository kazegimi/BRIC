//
//  MainTableViewController.m
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController {
    DownloadManager *downloadManager;
    NSDictionary *listDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    downloadManager = [[DownloadManager alloc] init];
    downloadManager.delegate = self;
    
    listDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"listDictionary"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = listDictionary[@"Folders"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = listDictionary[@"Folders"][indexPath.row][@"FolderName"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSub"]) {
        SubTableViewController *subTableViewController = segue.destinationViewController;
        subTableViewController.folderNumber = [self.tableView indexPathForSelectedRow].row;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toSub" sender:nil];
}

- (IBAction)refresh:(id)sender {
    [downloadManager startDownloading];
}

- (void)didFinishDownloadingList {
    [self.refreshControl endRefreshing];
    
    listDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"listDictionary"];
    [self.tableView reloadData];
}

@end
