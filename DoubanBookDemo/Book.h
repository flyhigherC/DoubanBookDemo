//
//  Book.h
//  DoubanBookSearch
//
//  Created by AIR on 6/10/15.
//  Copyright (c) 2015 AIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageGroup.h"

@interface Book : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) ImageGroup *images;

@end
