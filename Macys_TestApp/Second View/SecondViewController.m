//
//  SecondViewController.m
//  Macys_TestApp
//
//  Created by Sameer Ghate on 03/02/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize callCount = _callCount;


#pragma mark - SecondViewController singleton

/**
 Returns a singleton object of SecondViewController that handles the counter to number of times this screen is visited.
 @returns A shared instance of SecondViewController class.
 */
+ (instancetype)sharedInstance  {
    
    static SecondViewController *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:[NSBundle mainBundle]];
    });
    sharedInstance->_callCount++;
    return sharedInstance;
}

- (id)init  {
    
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _callCount = 0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated   {
    
    _labelCounter.text = [NSString stringWithFormat:@"Tap # %d",_callCount];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pop:(id)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
