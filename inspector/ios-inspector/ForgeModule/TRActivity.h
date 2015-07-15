//
//  TRActivity.h
//  ForgeInspector
//
//  Created by Giles Van Gruisen on 11/4/13.
//  Copyright (c) 2013 Trigger Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRActivity : NSObject <UIPopoverControllerDelegate> {
    UIPopoverController *popover;
    UIActivityViewController *shareSheet;
}

@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) UIActivityViewController *shareSheet;

- (id)initWithText:(NSString *)text URL:(NSString *)url archived:(BOOL)archived publicURL:(NSString *)publicURL;
- (void)presentControllerInView:(UIView *)view;

@end
