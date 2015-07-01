//
//  TweetCell.h
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@end
