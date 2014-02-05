//
//  ViewController.m
//  Macys_TestApp
//
//  Created by Admin on 03/02/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
{
    NSArray *tilesArray;
    NSArray *offersArray;
    NSInteger numberOfTileRows;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    tilesArray = @[@"HomePageTile1.png",
                   @"HomePageTile2.png",
                   @"HomePageTile3.png",
                   @"HomePageTile4.png",
                   @"HomePageTile5.png",
                   @"HomePageTile6.png"];
    
    offersArray = @[@"SampleOfferImage1.png",
                    @"SampleOfferImage2.png",
                    @"SampleOfferImage3.png"];
    
    NSInteger totalTiles = tilesArray.count;
    NSInteger modNumberofTiles = (totalTiles%3!=0?1:0);
    numberOfTileRows = totalTiles/3 + modNumberofTiles;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableviewDatasource

#define kOfferCellIdentifier @"OfferCellIdentifier"
#define kTilesCellIdentifier @"TilesCellIdentifier"
#define kNumberOfTilesPerRow 3

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows = numberOfTileRows + offersArray.count;
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kOfferCellIdentifier];
        [cell.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *contentImageview = (UIImageView*)obj;
                [contentImageview setImage:[UIImage imageNamed:[offersArray objectAtIndex:0]]];
                *stop = TRUE;
            }
        }];
    }
    else if (indexPath.row > 0 && (indexPath.row <= numberOfTileRows)) {
        TilesCustomCell *tileCell = [self setupTilesCustomCellRowForTableview:tableView indexpath:indexPath];
        cell = tileCell;
    }
    else if (indexPath.row >= numberOfTileRows+1)  {
        cell = [tableView dequeueReusableCellWithIdentifier:kOfferCellIdentifier];
        [cell.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *contentImageview = (UIImageView*)obj;
                [contentImageview setImage:[UIImage imageNamed:[offersArray objectAtIndex:(indexPath.row - numberOfTileRows)]]];
                *stop = TRUE;
            }
        }];
    }
    
    return cell;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self pushToSecondViewController:nil];
    }
    else if (indexPath.row > 0 && (indexPath.row <= numberOfTileRows)) {
    }
    else if (indexPath.row >= numberOfTileRows+1)  {
        [self pushToSecondViewController:nil];
    }
}

/**
 Creates a Tiles custom cell that places tiles.
 @param tableView A reference of the tableview
 @param indexPath Indexpath of the tableView for which custom cell has to be drawn.
 @returns A TilesCusotmCell instance.
 */
- (TilesCustomCell*)setupTilesCustomCellRowForTableview:(UITableView*)tableView indexpath:(NSIndexPath*)indexPath  {
    
    NSInteger totalTiles = tilesArray.count;
    NSInteger tilesArrayPointer = (indexPath.row-1)*kNumberOfTilesPerRow;
    
    TilesCustomCell *tileCell = [tableView dequeueReusableCellWithIdentifier:kTilesCellIdentifier];
    
    [tileCell.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)obj;
            button.hidden = TRUE;
        }
    }];

    for (int tileCounter = 0; tileCounter < 3; tileCounter++) {
        
        if (tileCounter == 0) {
            if (tilesArrayPointer+tileCounter < totalTiles)  {
                tileCell.buttonLeftTile.hidden = FALSE;
                [tileCell.buttonLeftTile setImage:[UIImage imageNamed:[tilesArray objectAtIndex:tilesArrayPointer]] forState:UIControlStateNormal];
                [tileCell.buttonLeftTile addTarget:self action:@selector(pushToSecondViewController:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else if (tileCounter == 1)  {
            if (tilesArrayPointer+tileCounter < totalTiles)  {
                tileCell.buttonMiddleTile.hidden = FALSE;
                [tileCell.buttonMiddleTile setImage:[UIImage imageNamed:[tilesArray objectAtIndex:tilesArrayPointer+1]] forState:UIControlStateNormal];
                [tileCell.buttonMiddleTile addTarget:self action:@selector(pushToSecondViewController:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else if (tileCounter == 2)  {
            if (tilesArrayPointer+tileCounter < totalTiles)  {
                tileCell.buttonRightTile.hidden = FALSE;
                [tileCell.buttonRightTile setImage:[UIImage imageNamed:[tilesArray objectAtIndex:tilesArrayPointer+2]] forState:UIControlStateNormal];
                [tileCell.buttonRightTile addTarget:self action:@selector(pushToSecondViewController:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    return tileCell;
}

/**
 Performs a push action to next view controller, i.e. SecondViewController.
 */
- (IBAction)pushToSecondViewController:(id)sender {
    SecondViewController *sv = [SecondViewController sharedInstance];
    
    [self.navigationController pushViewController:sv animated:YES];
}


#pragma mark - Barcode scan button action

- (IBAction)barcodeScanButtonAction:(id)sender  {
    UIAlertView *scanAlert = [[UIAlertView alloc] initWithTitle:@"Barcode Scanner" message:@"Barcode scan successful." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [scanAlert show];
    scanAlert = nil;
}

@end

#pragma mark - TilesCustomCell implementation

@implementation TilesCustomCell

@end