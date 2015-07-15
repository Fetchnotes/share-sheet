//
//  TRArchiveActivity.m
//  ForgeModule
//
//  Created by Giles Van Gruisen on 11/18/13.
//  Copyright (c) 2013 Fetchnotes, Inc. All rights reserved.
//

#import "TRArchiveActivity.h"

@implementation TRArchiveActivity

@synthesize activityTitle = _activityTitle;
@synthesize activityImage = _activityImage;

- (NSString *)activityType {
    return  @"twentyFiveCharToBeEasier.Archive";
}
- (NSString *)activityTitle {
    return _activityTitle ? _activityTitle : @"Archive";
}

- (void)setActivityTitle:(NSString *)activityTitle {
    _activityTitle = activityTitle;
}

- (UIImage *) activityImage {
    return _activityImage ? _activityImage : [UIImage imageNamed:@"sharesheet.bundle/Archive"];
}
- (void)setActivityImage:(UIImage *)activityImage {
    _activityImage = activityImage;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (UIViewController *)activityViewController {
    return nil;
}

- (void)performActivity {
    [[ForgeApp sharedApp] event:@"sharesheet.archive" withParam:nil];
    [self activityDidFinish:YES];
}


@end
