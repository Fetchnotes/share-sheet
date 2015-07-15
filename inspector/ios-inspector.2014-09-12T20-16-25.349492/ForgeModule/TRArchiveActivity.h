//
//  TRArchiveActivity.h
//  ForgeModule
//
//  Created by Giles Van Gruisen on 11/18/13.
//  Copyright (c) 2013 Fetchnotes, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRArchiveActivity : UIActivity

@property (nonatomic, setter=setActivityTitle:) NSString *activityTitle;
@property (nonatomic, setter=setActivityImage:) UIImage *activityImage;

- (void)setActivityTitle:(NSString *)newActivityTitle;

@end
