//
//  DownloadManager.h
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ListDownloader.h"
#import "FileDownloader.h"

@protocol DownloadManagerDelegate

@optional

- (void)didFinishDownloadingList;
- (void)didFailDownloadingList;

@end

@interface DownloadManager : NSObject <ListDownloaderDelegate, FileDownloaderDelegate>

@property (strong, nonatomic) id<DownloadManagerDelegate> delegate;

- (void)startDownloading;

@end
