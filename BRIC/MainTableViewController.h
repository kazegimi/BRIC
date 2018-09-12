//
//  MainTableViewController.h
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DownloadManager.h"
#import "SubTableViewController.h"

@interface MainTableViewController : UITableViewController <DownloadManagerDelegate>

- (IBAction)refresh:(id)sender;

@end
