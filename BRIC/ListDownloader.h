//
//  ListDownloader.h
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListDownloaderDelegate

@optional

- (void)didFinishDownloadingListWithData:(NSData *)data;
- (void)didFailDownloadingList;

@end

@interface ListDownloader : NSObject <NSURLSessionDelegate>

@property (strong, nonatomic) id<ListDownloaderDelegate> delegate;

- (void)startDownloadingList;

@end
