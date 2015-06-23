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
#import "ImageGroup.h"
#import "SearchBookViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *books;
@property (nonatomic, strong) NSString *key;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureRestKit];
    [self loadBookInformation];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (instancetype) init
{
    //self = [super initWithStyle:UITableViewStylePlain];
    self = [super initWithStyle: UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                                                style:nil
                                                                                               target:self
                                                               action: @selector(goBackHome)];
        
        navItem.leftBarButtonItem = bbi;
    }
    return self;
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void) configureRestKit
{
    NSURL *baseURL = [NSURL URLWithString:@"https://api.douban.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL: baseURL];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient: client];
    
    RKObjectMapping *bookMapping = [RKObjectMapping mappingForClass: [Book class]];
    [bookMapping addAttributeMappingsFromArray: @[@"title", @"publisher"]];
    
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass: [ImageGroup class]];
    [imageMapping addAttributeMappingsFromArray:@[@"large", @"medium", @"small"]];
    
    [bookMapping addPropertyMapping: [RKRelationshipMapping relationshipMappingFromKeyPath: @"images"
                                                                                                                                             toKeyPath: @"images"
                                                                                                                                          withMapping: imageMapping]];
    
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
    NSDictionary *queryParams = @{@"q" : _key};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/book/search"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _books = mappingResult.array;
//                                                  dispatch_sync(dispatch_get_main_queue(), ^{
//                                                      [self.tableView reloadData];
//                                                  });
                                                  [self.tableView reloadData];
                                                  NSLog(@"Get the book list!!%@", [[_books objectAtIndex:0] title]);
                                                 // NSLog(@"%lu", (unsigned long)[[[[_books objectAtIndex:0] images] objectAtIndex:0] rangeOfString:@" small ="].location);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@" there is no this book: %@", error);
                                              }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: nil];
    Book *book = _books[indexPath.row];
    cell.textLabel.text = [book title];
    cell.detailTextLabel.text = [book publisher];
    //cell.imageView.image = [self getImageFromURL:@"http://img3.douban.com/spic/s1957104.jpg"];
    cell.imageView.image = [self getImageFromURL: book.images.small];
    //NSLog(@"%@",[book publisher]);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _books.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Here you must return the number of sectiosn you want
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

- (void) passTrendValues: (NSString *) keyWorld {
    NSLog(@"successfully");
    _key = keyWorld;
}

- (void) goBackHome {
    NSLog(@"Go back home!");
    [self dismissModalViewControllerAnimated:YES];
}
@end
