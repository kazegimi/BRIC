//
//  MainViewController.m
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTapGestureRcognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    singleTapGestureRcognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTapGestureRcognizer];
    
    self.pdfView.autoScales = YES;
    self.pdfView.displayDirection = kPDFDisplayDirectionHorizontal;
    self.pdfView.displayMode = kPDFDisplaySinglePageContinuous;
    self.pdfView.displaysRTL = NO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:@"test.pdf"];
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    PDFDocument *document = [[PDFDocument alloc] initWithURL:URL];
    self.pdfView.document = document;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)singleTapped:(UITapGestureRecognizer *)recognizer {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBar.hidden animated:YES];
}

@end
