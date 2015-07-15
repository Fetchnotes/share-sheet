//
//  TRActivityProvider.m
//  ForgeModule
//
//  Created by Giles Van Gruisen on 10/31/13.
//  Copyright (c) 2013 Trigger Corp. All rights reserved.
//

#import "TRActivityProvider.h"
#import "share_sheet_API.h"

@implementation TRActivityProvider

@synthesize twitter;
@synthesize facebook;
@synthesize sms;
@synthesize email;
@synthesize pasteboard;

- (id) activityViewController:(UIActivityViewController *)activityViewController
          itemForActivityType:(NSString *)activityType
{
    if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
        return twitter;
    } else if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
        return facebook;
    } else if ([activityType isEqualToString:UIActivityTypeMessage]) {
        return sms;
    } else if ([activityType isEqualToString:UIActivityTypeMail]) {
        return email;
    } else if ([activityType isEqualToString:UIActivityTypeCopyToPasteboard]) {
        return pasteboard;
    }
    return nil;
}
- (id) activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController { return @""; }


@end
