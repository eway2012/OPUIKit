
//
//  OPViewController.m
//  CloudAssassin
//
//  Created by Brandon Williams on 6/13/11.
//  Copyright 2011 Hashable. All rights reserved.
//

#import "OPViewController.h"
#import "UIViewController+Opetopic.h"
#import "UIViewController+OPUIKit.h"
#import "OPMacros.h"
#import "Quartz+Opetopic.h"

@implementation OPViewController

// OPStyle storage
@synthesize backgroundColor = _backgroundColor;
@synthesize backgroundImage = _backgroundImage;
@synthesize defaultTitle = _defaultTitle;
@synthesize defaultSubtitle = _defaultSubtitle;
@synthesize defaultTitleImage = _defaultTitleImage;
@synthesize titleFont = _titleFont;
@synthesize subtitleFont = _subtitleFont;
@synthesize titleColor = _titleColor;
@synthesize titleShadowColor = _titleShadowColor;
@synthesize titleShadowOffset = _titleShadowOffset;

#pragma mark -
#pragma mark Object lifecycle
#pragma mark -

-(id) init {
	if (! (self = [super init]))
		return nil;
	
    // apply stylings
    [[self styling] applyTo:self];
	
	return self;
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    DLogClassAndMethod();
}

#pragma mark -
#pragma mark View lifecycle
#pragma mark -

-(void) viewDidLoad {
    [super viewDidLoad];
    DLogClassAndMethod();
    
    // default the background color if the view doesn't already have one
	if (self.backgroundImage)
    {
        if (! CGSizeIsPowerOfTwo(self.backgroundImage.size)) {
            DLog(@"==============================================================");
            DLog(@"Pattern image drawing is most efficient with power of 2 images");
            DLog(@"==============================================================");
        }
		self.view.backgroundColor = [UIColor colorWithPatternImage:self.backgroundImage];
    }
    else if (self.backgroundColor)
        self.view.backgroundColor = self.backgroundColor;
    else
        self.view.backgroundColor = [UIColor whiteColor];
    
    // set the default navigation item title view
    if (self.defaultTitleImage && !self.navigationItem.titleView)
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:self.defaultTitleImage];
    if (self.defaultTitle && !self.title)
        [self setTitle:self.defaultTitle subtitle:self.defaultSubtitle];
}

@end
