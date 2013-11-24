//
//  NexumProfileViewController.h
//  Twitter iOS 1.0
//
//  Created by Cristian Castillo on 11/14/13.
//  Copyright (c) 2013 NexumDigital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NexumProfileCell.h"

@interface NexumProfileViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *profile;

@property (strong, nonatomic) NSMutableArray *profiles;
@property (strong, nonatomic) NSDictionary *nextProfile;

@property (strong, nonatomic) IBOutlet UIImageView *back;
@property (strong, nonatomic) IBOutlet UIView *mainPlaceholder;
@property (strong, nonatomic) IBOutlet UIView *infoPlaceholder;
@property (strong, nonatomic) IBOutlet UIImageView *backOverlay;
@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *description;

@property (strong, nonatomic) NSData *pictureData;
@property (strong, nonatomic) UIImage *pictureImage;
@property (strong, nonatomic) NSData *backData;
@property (strong, nonatomic) UIImage *backImage;

@property (strong, nonatomic) IBOutlet UIToolbar *actionToolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *followingButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *followersButton;

@property (assign, nonatomic) BOOL isLoading;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *page;

- (IBAction)followingAction:(id)sender;
- (IBAction)followersAction:(id)sender;

- (void) clearTable;
- (void) loadProfileImage;
- (void) loadBackImage;

@end
