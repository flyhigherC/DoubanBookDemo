//
//  BookStore.m
//  DoubanBookDemo
//
//  Created by AIR on 6/15/15.
//  Copyright (c) 2015 AIR. All rights reserved.
//

#import "BookStore.h"

@interface BookStore()

@property (nonatomic) NSMutableArray *privateBooks;

@end

@implementation BookStore

+ (instancetype) sharedBookStore
{
    static BookStore *sharedBookStore = nil;
    
    if (!sharedBookStore) {
        sharedBookStore = [[BookStore alloc] initPrivate];
    }
    
    return sharedBookStore;
}

- (instancetype) initPrivate
{
    self = [super init];
    
    if (self) {
        _privateBooks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (instancetype) init
{
    @throw  [NSException exceptionWithName:@"Singleton"
                                                              reason: @"Use +[BookStore sharedBookStore]"
                                                            userInfo: nil];
    
    return nil;
}

- (NSArray *) allBooks
{
    return  self.privateBooks;
}

@end
