//
//  DownloadManager.m
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager {
    ListDownloader *listDownloader;
    FileDownloader *fileDownloader;
    NSInteger sequence;
}

- (void)startDownloading {
    listDownloader = [[ListDownloader alloc] init];
    listDownloader.delegate = self;
    
    [listDownloader startDownloadingList];
}

- (void)didFinishDownloadingListWithData:(NSData *)data {
    NSDictionary *listDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:listDictionary forKey:@"listDictionary"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.delegate didFinishDownloadingList];
    
    // FileIDの取り出し
    NSMutableArray *fileIDsArray = [NSMutableArray new];
    NSArray *foldersArray = listDictionary[@"Folders"];
    for (NSDictionary *folderDictionary in foldersArray) {
        NSArray *filesArray = folderDictionary[@"Files"];
        for (NSDictionary *fileDictionary in filesArray) {
            [fileIDsArray addObject:fileDictionary[@"FileId"]];
        }
    }
    
    fileDownloader = [[FileDownloader alloc] init];
    fileDownloader.delegate = self;
    sequence = 0;
    [fileDownloader startDownloadingFileWithID:fileIDsArray[sequence]];
}

- (void)didFinishDownloadingFileWithData:(NSData *)data {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:@"test.pdf"];
    BOOL result = [data writeToFile:filePath atomically:NO];
    if (result) {
        //NSLog(@"%@", @"データの保存に成功");
    }
    
    sequence++;
    //[fileDownloader startDownloadingFileWithID:fileIDsArray[sequence]];
}

@end
