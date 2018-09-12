//
//  FileDownloader.h
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FileDownloaderDelegate

@optional

- (void)didFinishDownloadingFileWithData:(NSData *)data;
- (void)didFailDownloadingFile;

@end

@interface FileDownloader : NSObject <NSURLSessionDelegate>

@property (strong, nonatomic) id<FileDownloaderDelegate> delegate;

- (void)startDownloadingFileWithID:(NSString *)fileID;

@end
