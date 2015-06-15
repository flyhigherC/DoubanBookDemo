//
//  BookStore.h
//  DoubanBookDemo
//
//  Created by AIR on 6/15/15.
//  Copyright (c) 2015 AIR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

@interface BookStore : NSObject

+ (instancetype) sharedBookStore;
- (Book *) createBook;

@end
