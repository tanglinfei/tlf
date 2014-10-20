//
//  EviInfViewCell.m
//  LoveEnvironmennt
//
//  Created by  on 14-9-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "EviInfViewCell.h"
@implementation EviInfViewCell
@synthesize pictureView = _pictureView;
@synthesize titleLabel = _titleLabel;
@synthesize contentLabel = _contentLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        _pictureView = [[UIImageView alloc] init];
        _titleLabel     = [[UILabel alloc] init];
        _contentLabel   = [[UILabel alloc] init];
        //添加到cell上
        [self.contentView addSubview:_pictureView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_contentLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _pictureView.frame  = CGRectMake(1,5, 100, 80);
    _titleLabel.frame   = CGRectMake(110, 10, 200, 16);
    _contentLabel.frame = CGRectMake(105, 30, 200, 50);
    _titleLabel.font    = [UIFont boldSystemFontOfSize:15];
    _contentLabel.font  = [UIFont boldSystemFontOfSize:12];
     //_titleLabel.adjustsFontSizeToFitWidth = YES;
       _contentLabel.numberOfLines = 2;
}

@end
