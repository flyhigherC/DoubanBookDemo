//
//  SearchBookViewController.m
//  DoubanBookDemo
//
//  Created by AIR on 6/18/15.
//  Copyright (c) 2015 AIR. All rights reserved.
//

#import "SearchBookViewController.h"
#import "ViewController.h"

@interface SearchBookViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchContentField;

@property (weak, nonatomic) IBOutlet UIButton *searchBookButton;

@end

@implementation SearchBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBookButton:(id)sender {
    NSLog(@"123");
    
    ViewController *controller = [[ViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: controller];
    //navController.navigationItem.title = @"back";
    
    self.trendDeletgate = controller;
    [self.trendDeletgate passTrendValues: _searchContentField.text];
    NSLog(@"ios");
    [self presentViewController:navController
                                animated:YES
                             completion:nil];
    NSLog(@"Yes");
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
