//
//  AQIDetailCell.m
//  LoveEnvironmennt
//
//  Created by  on 14-10-6.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AQIDetailCell.h"

@implementation AQIDetailCell
@synthesize nameLabel;
@synthesize concentrationLabel;
@synthesize levelLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        nameLabel = [[UILabel alloc] init];
        concentrationLabel = [[UILabel alloc] init];
        levelLabel   = [[UILabel alloc] init];
        //添加到cell上
        [self.contentView addSubview:nameLabel];
        [self.contentView addSubview:concentrationLabel];
        [self.contentView addSubview:levelLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
}
//定制cell
-(void)layoutSubviews
{
    [super layoutSubviews];
    nameLabel.frame = CGRectMake(0, 0, 107+3, 44);
    nameLabel.font  = [UIFont boldSystemFontOfSize:12];
    //addressLabel.backgroundColor = [UIColor yellowColor];
    nameLabel.textAlignment =  UITextAlignmentRight;
    nameLabel.numberOfLines =2;
    
    concentrationLabel.frame     = CGRectMake(110, 0, 110, 44);
    //AQILabel.backgroundColor = [UIColor whiteColor];
    concentrationLabel.font  = [UIFont boldSystemFontOfSize:14];
    concentrationLabel.textAlignment =  UITextAlignmentRight;
    
    levelLabel.frame   = CGRectMake(221, 0, 100-1, 44);
    //levelLabel.backgroundColor = [UIColor yellowColor];
    levelLabel.font  = [UIFont boldSystemFontOfSize:12];
    levelLabel.textAlignment =  UITextAlignmentCenter;
    
    
    
    
}




@end
