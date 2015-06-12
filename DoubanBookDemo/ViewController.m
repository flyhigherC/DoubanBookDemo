//
//  ViewController.m
//  DoubanBookDemo
//
//  Created by AIR on 6/11/15.
//  Copyright (c) 2015 AIR. All rights reserved.
//

#import "ViewController.h"
#import <RestKit/RestKit.h>
#import "Book.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *books;

@end

@implementation ViewController

- (instancetype) init
{
    self = [super initWithStyle: UITableViewStylePlain];
    return self;
}

+  (instancetype) initWithStyle:(UITableViewStyle) style
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"book"];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureRestKit];
    [self loadBookInformation];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (void) configureRestKit
{
    NSURL *baseURL = [NSURL URLWithString:@"https://api.douban.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL: baseURL];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient: client];
    
    RKObjectMapping *bookMapping = [RKObjectMapping mappingForClass: [Book class]];
    [bookMapping addAttributeMappingsFromArray: @[@"title", @"publisher"]];
    
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping: bookMapping
                                                 method:RKRequestMethodGET
                                            pathPattern: @"/v2/book/search"
                                                keyPath: @"books"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void) loadBookInformation
{
    NSDictionary *queryParams = @{@"q" : @"Java"};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/book/search"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _books = mappingResult.array;
//                                                 [self.tableView reloadData];
                                                  NSLog(@"Get the book list!! %@", [[_books objectAtIndex:0] title]);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@" there is no this book: %@", error);
                                              }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Book *book = _books[indexPath.row];
    cell.textLabel.text = [book title];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _books.count;
}

@end
