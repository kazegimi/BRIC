//
//  FileDownloader.m
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "FileDownloader.h"

@implementation FileDownloader {
    NSMutableData *mutableData;
}

- (void)startDownloadingFileWithID:(NSString *)fileID {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlString = @"http://www.bric.jalnet:82/WebSvcProviderMobile/Service/DlFileSvc.aspx";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    NSDictionary *dictionary = @{@"FileId":fileID, @"PersonnelID":@"00051139"};
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:nil];
    request.HTTPMethod = @"POST";
    request.HTTPBody = JSONData;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    mutableData = [[NSMutableData alloc] init];
    
    [task resume];
}

// レスポンス受信時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);// どのレスポンスが来ても通信を継続
}

// データを受信時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [mutableData appendData:data];
}

// 通信完了、または失敗時の処理
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (!error) {
        // 成功時の処理
        [self.delegate didFinishDownloadingFileWithData:mutableData];
    } else {
        // 失敗時の処理
        [self.delegate didFailDownloadingFile];
    }
    [session invalidateAndCancel];
}

@end
