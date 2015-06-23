//
//  SearchBookViewController.h
//  DoubanBookDemo
//
//  Created by AIR on 6/18/15.
//  Copyright (c) 2015 AIR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassTrendValueDelegate

- (void) passTrendValues : (NSString *) keyWorld;

@end

@interface SearchBookViewController : UIViewController

@property (strong, nonatomic) id <PassTrendValueDelegate> trendDeletgate;

@end

