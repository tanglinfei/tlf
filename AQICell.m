//
//  AQICell.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AQICell.h"

@implementation AQICell
@synthesize addressLabel;
@synthesize AQILabel;
@synthesize levelLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        addressLabel = [[UILabel alloc] init];
        AQILabel     = [[UILabel alloc] init];
        levelLabel   = [[UILabel alloc] init];
        //添加到cell上
        [self.contentView addSubview:addressLabel];
        [self.contentView addSubview:AQILabel];
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
    addressLabel.frame = CGRectMake(0, 0, 107+3, 44);
    addressLabel.font  = [UIFont boldSystemFontOfSize:12];
    //addressLabel.backgroundColor = [UIColor yellowColor];
    addressLabel.textAlignment =  UITextAlignmentRight;
    
    AQILabel.frame     = CGRectMake(110, 0, 110, 44);
    //AQILabel.backgroundColor = [UIColor whiteColor];
    AQILabel.font  = [UIFont boldSystemFontOfSize:14];
   AQILabel.textAlignment =  UITextAlignmentRight;
    
    levelLabel.frame   = CGRectMake(221, 0, 100-1, 44);
    //levelLabel.backgroundColor = [UIColor yellowColor];
    levelLabel.font  = [UIFont boldSystemFontOfSize:12];
    levelLabel.textAlignment =  UITextAlignmentCenter;
    

}

@end
