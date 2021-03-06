//
//  UIViewController+OPUIKit.m
//  OPUIKit
//
//  Created by Brandon Williams on 1/16/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import "UIViewController+OPUIKit.h"
#import "OPTableViewController.h"
#import "OPViewController.h"
#import "OPStyle.h"
#import "OPMacros.h"

@implementation UIViewController (OPUIKit)

-(id) initWithTitle:(NSString*)title subtitle:(NSString*)subtitle {
    if (! (self = [self init]))
        return nil;
    
    [self setTitle:title subtitle:subtitle];
    
    return self;
}

-(void) setTitle:(NSString*)title subtitle:(NSString*)subtitle {
    
    self.title = title;
    
    UIColor *titleColor = [UIColor whiteColor];
    UIFont *titleFont = [UIFont boldSystemFontOfSize:18.0f];
    UIFont *subtitleFont = [UIFont boldSystemFontOfSize:13.0f];
    UIColor *titleShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    CGSize titleShadowOffset = CGSizeZero;
    
    if ([self isKindOfClass:[OPTableViewController class]] || [self isKindOfClass:[OPViewController class]])
    {
        titleColor = [(id)self titleColor] ?: titleColor;
        titleFont = [(id)self titleFont] ?: titleFont;
        subtitleFont = [(id)self subtitleFont] ?: subtitleFont;
        titleShadowColor = [(id)self titleShadowColor] ?: titleShadowColor;
        titleShadowOffset = [(id)self titleShadowOffset];
    }
    
    if (title && subtitle)
        titleFont = [UIFont fontWithName:subtitleFont.fontName size:subtitleFont.pointSize+2.0f];
    
	UIView *wrapper = [[UIView alloc] initWithFrame:CGRectZero];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	titleLabel.text = title;
	titleLabel.textColor = titleColor;
	titleLabel.shadowColor = titleShadowColor;
    titleLabel.shadowOffset = titleShadowOffset;
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.font = titleFont;
	titleLabel.numberOfLines = 1;
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.opaque = NO;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[titleLabel sizeToFit];
	
	UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	if (subtitle)
    {
		subtitleLabel.text = subtitle;
		subtitleLabel.textColor = titleColor;
		subtitleLabel.shadowColor = titleShadowColor;
        subtitleLabel.shadowOffset = titleShadowOffset;
		subtitleLabel.textAlignment = UITextAlignmentCenter;
		subtitleLabel.font = subtitleFont;
		subtitleLabel.numberOfLines = 1;
		subtitleLabel.backgroundColor = [UIColor clearColor];
		subtitleLabel.opaque = NO;
        subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[subtitleLabel sizeToFit];
	}
	
	CGFloat maxWidth = MAX(titleLabel.frame.size.width, subtitleLabel.frame.size.width);
	wrapper.frame = CGRectMake(0.0, 0.0, maxWidth, 44.0);
	titleLabel.frame = CGRectMake(0.0, (subtitle ? 3.0 : 12.0), maxWidth, 20.0);
	[wrapper addSubview:titleLabel];
	
	if (subtitle)
    {
		subtitleLabel.frame = CGRectMake(0.0, 21.0, maxWidth, 16.0);
		[wrapper addSubview:subtitleLabel];
	}
	
	self.navigationItem.titleView = wrapper;
}

@end
