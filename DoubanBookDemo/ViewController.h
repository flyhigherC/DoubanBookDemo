//
//  ViewController.h
//  DoubanBookDemo
//
//  Created by AIR on 6/11/15.
//  Copyright (c) 2015 AIR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBookViewController.h"

@interface ViewController : UITableViewController

SearchBookViewController<PassTrendValueDelegate>;

@end

