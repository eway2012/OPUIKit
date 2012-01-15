//
//  OPButton.m
//  OPUIKit
//
//  Created by Brandon Williams on 1/14/12.
//  Copyright (c) 2012 Opetopic. All rights reserved.
//

#import "OPButton.h"
#import "NSNumber+Opetopic.h"

@interface OPButton (/**/)
@property (nonatomic, strong) NSMutableDictionary *drawingBlocks;
@end

@implementation OPButton

@synthesize drawingBlocks;

-(id) initWithFrame:(CGRect)frame {
    if (! (self = [super initWithFrame:frame]))
        return nil;
    
    self.drawingBlocks = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                          [NSMutableArray new], [NSNumber numberWithInt:UIControlStateNormal], 
                          [NSMutableArray new], [NSNumber numberWithInt:UIControlStateHighlighted], 
                          [NSMutableArray new], [NSNumber numberWithInt:UIControlStateDisabled], 
                          [NSMutableArray new], [NSNumber numberWithInt:UIControlStateSelected], nil];
    
    return self;
}

-(void) addDrawingBlock:(OPButtonDrawingBlock)block forState:(UIControlState)state {
    
    if (state == UIControlStateNormal)
        [[self.drawingBlocks objectForKey:[NSNumber numberWithInt:UIControlStateNormal]] addObject:[block copy]];
    
    if (state & UIControlStateHighlighted)
        [[self.drawingBlocks objectForKey:[NSNumber numberWithInt:UIControlStateHighlighted]] addObject:[block copy]];
    
    if (state & UIControlStateDisabled)
        [[self.drawingBlocks objectForKey:[NSNumber numberWithInt:UIControlStateDisabled]] addObject:[block copy]];
    
    if (state & UIControlStateSelected)
        [[self.drawingBlocks objectForKey:[NSNumber numberWithInt:UIControlStateSelected]] addObject:[block copy]];
    
    [self setNeedsDisplay];
}

-(void) removeDrawingBlocksForState:(UIControlState)state {
    
}

-(void) removeAllDrawingBlocks {
    self.drawingBlocks = [NSMutableDictionary new];
    [self setNeedsDisplay];
}

-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    for (OPButtonDrawingBlock block in [self.drawingBlocks objectForKey:[NSNumber numberWithInt:UIControlStateNormal]])
        block(self, rect, c);
    
    for (NSNumber *drawState in self.drawingBlocks)
    {
        if ([drawState intValue] & self.state)
        {
            for (OPButtonDrawingBlock block in [self.drawingBlocks objectForKey:drawState])
                block(self, rect, c);
        }
    }
}

@end