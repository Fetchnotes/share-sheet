//
//  TRActivityProvider.h
//  ForgeModule
//
//  Created by Giles Van Gruisen on 10/31/13.
//  Copyright (c) 2013 Trigger Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRActivityProvider : UIActivityItemProvider <UIActivityItemSource>

@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *sms;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *pasteboard;

@end

@interface TRActivityIcon : UIActivity

@end