//
//  AppDelegate.h
//  BRIC
//
//  Created by Eiichi Hayashi on 2018/09/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

