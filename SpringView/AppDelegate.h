//
//  AppDelegate.h
//  SpringView
//
//  Created by 王文科 on 2017/4/6.
//  Copyright © 2017年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

