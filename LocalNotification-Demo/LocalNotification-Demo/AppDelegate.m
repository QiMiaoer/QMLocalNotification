//
//  AppDelegate.m
//  LocalNotification-Demo
//
//  Created by zyx on 17/3/25.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if (application.currentUserNotificationSettings.types==UIUserNotificationTypeNone) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:setting];
    } else {
        UILocalNotification *notification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
        [self showLocalNotification:notification];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types!=UIUserNotificationTypeNone) {
        [application scheduleLocalNotification:[self createLocalNotification]];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (notification) {
        [self showLocalNotification:notification];
    }
}

- (void)showLocalNotification:(UILocalNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *title = userInfo[@"user"];
    NSString *message = userInfo[@"message"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [alert show];
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
}

- (UILocalNotification *)createLocalNotification {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *date = [formatter dateFromString:@"2017-3-25 14:56:00"];
    notification.fireDate = date;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.repeatInterval = NSCalendarUnitDay;
    notification.alertBody = @"新功能哦，快来体验吧！";
    notification.applicationIconBadgeNumber = 1;
    notification.alertAction = @"打开应用";
    notification.alertLaunchImage = @"Default";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.userInfo = @{
                              @"id": @1,
                              @"user": @"qimiao",
                              @"message":@"没错，我就是通知，哈哈哈"
                              };
    return notification;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
