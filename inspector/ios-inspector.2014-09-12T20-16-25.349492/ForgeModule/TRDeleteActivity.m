//
//  TRDeleteActivity.m
//  ForgeModule
//
//  Created by Giles Van Gruisen on 11/18/13.
//  Copyright (c) 2013 Trigger Corp. All rights reserved.
//

#import "TRDeleteActivity.h"

@implementation TRDeleteActivity

- (NSString *)activityType {
    return  @"twentyFiveCharToBeEasier.Delete";
}
- (NSString *)activityTitle {
    return @"Delete";
}

- (UIImage *) activityImage {
    return [UIImage imageNamed:@"sharesheet.bundle/Delete"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (UIViewController *)activityViewController {
    return nil;
}

- (void)performActivity {
    [[ForgeApp sharedApp] event:@"sharesheet.delete" withParam:nil];
    [self activityDidFinish:YES];
}

@end
