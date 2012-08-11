//
//  AppDelegate.m
//  KMPullRefresh
//
//  Created by Kazutaka Mukai on 08/01/12.
//  Copyright (c) 2012 Kazutaka Mukai. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
  rootViewController.loadMoreEnabled                       = YES;
  rootViewController.loadMoreTapEnabled                    = YES;
  rootViewController.animateReturnAfterRefreshWithDuration = 0.2f;
  
  UIWindow *window = self.window;
  window.rootViewController = rootViewController;
  [window makeKeyAndVisible];
  
  return YES;
}

@end
