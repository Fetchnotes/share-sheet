//
//  TRActivity.m
//  ForgeInspector
//
//  Created by Giles Van Gruisen on 11/4/13.
//  Copyright (c) 2013 Trigger Corp. All rights reserved.
//

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define UI_USER_INTERFACE_IDIOM() \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] ? \
[[UIDevice currentDevice] userInterfaceIdiom] : \
UIUserInterfaceIdiomPhone)

#import "TRActivity.h"
#import "TRArchiveActivity.h"
#import "TRDeleteActivity.h"
#import "TRActivityProvider.h"

@implementation TRActivity

@synthesize popover;
@synthesize shareSheet;

-(id)initWithText:(NSString *)text URL:(NSString *)url archived:(BOOL)archived publicURL:(NSString *)publicURL {
    if(self = [super init]) {
        // Set up activity pre provider (before note text)
        TRActivityProvider *activityPreProvider = [[TRActivityProvider alloc] init];
        activityPreProvider.email = @"Hey, thought you might be interested in this:\n";
        if (url) {
            activityPreProvider.facebook = [NSURL URLWithString:url];
        }
        
        // Set up activity post provider (after note text)
        TRActivityProvider *activityPostProvider = [[TRActivityProvider alloc] init];
        activityPostProvider.twitter = @"via @fetchnotes";
        activityPostProvider.facebook = @"\n(via Fetchnotes)";
        
        if ([publicURL length] > 0) {
            activityPostProvider.sms = [[NSString alloc] initWithFormat:@"\n\nMore on Fetchnotes: %@", publicURL];
            activityPostProvider.email = [[NSString alloc] initWithFormat:@"\n%@\n\nvia Fetchnotes (http://fetchnotes.com/)", publicURL];
        } else {
            activityPostProvider.sms = [[NSString alloc] initWithFormat:@"\n\nvia Fetchnotes"];
            activityPostProvider.email = [[NSString alloc] initWithFormat:@"\nvia Fetchnotes (http://fetchnotes.com/)"];
        }
        
        // Set up activity provider (note text)
        TRActivityProvider *activityProvider = [[TRActivityProvider alloc] init];
        if (SYSTEM_VERSION_LESS_THAN(@"7.0") && [text length] > 124) {
            NSString *newText = [text substringWithRange:NSMakeRange(0, 124)];
            activityProvider.twitter = newText;
        } else {
            activityProvider.twitter = text;
        }
        activityProvider.facebook = text;
        activityProvider.sms = text;
        activityProvider.email = text;
        activityProvider.pasteboard = text;

        // Pass activityItems to be concatenated (pre, note, post)
        NSArray *items = @[activityPreProvider, activityProvider, activityPostProvider];

        // Create instances of custom archive and delete activities
        TRArchiveActivity *archive = [[TRArchiveActivity alloc] init];
        TRDeleteActivity *delete = [[TRDeleteActivity alloc] init];
        
        // If current note is archived then lets change archive activity to say unarchive text/icon
        if (archived) {
            archive.activityTitle = @"Unarchive";
            archive.activityImage = [UIImage imageNamed:@"sharesheet.bundle/Feed"];
        }
        
        // Instantiate our shareSheet with items
        self.shareSheet = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:@[archive, delete]];
        
        // Only exclude airDrop if on 7+
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            self.shareSheet.excludedActivityTypes = @[UIActivityTypeAirDrop];
        }
        
    }
    return self;
}

-(void)presentControllerInView:(UIView *)view {
    [self.shareSheet setCompletionHandler:^(NSString *activityType, BOOL completed) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//        NSString *activity = [activityType substringFromIndex:25];
//        if (completed) {
//            [[ForgeApp sharedApp] event:@"sharesheet.track" withParam:activity];
//        }
    }];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Set up popover
        self.popover = [[UIPopoverController alloc] initWithContentViewController:self.shareSheet];
        UIView *mainView = [[[ForgeApp sharedApp] viewController] view];
        UIInterfaceOrientation orientation = [[[ForgeApp sharedApp] viewController] interfaceOrientation];
        CGFloat myWidth = 0.0;
        if(UIInterfaceOrientationIsLandscape(orientation)) {
            myWidth = mainView.frame.size.height;
        } else {
            myWidth = mainView.frame.size.width;
        }
        [self.popover presentPopoverFromRect:CGRectMake(myWidth-24, 74, 1, 1) inView:view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        [[[ForgeApp sharedApp] viewController] presentViewController:self.shareSheet animated:YES completion:nil];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.popover dismissPopoverAnimated:YES];
}

- (void)dealloc {
    NSLog(@"deallocating");
}

@end
