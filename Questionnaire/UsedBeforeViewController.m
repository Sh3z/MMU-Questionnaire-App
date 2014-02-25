//
//  UsedBeforeViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "UsedBeforeViewController.h"

@implementation UsedBeforeViewController

#pragma mark - Overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (NSString*)question
{
	return @"Have you used an iPad before?";
}

- (void)responsePressed:(UIButton *)button
{
	NSString* hasUsedText = [[button titleLabel] text];
	[self.builder appendResponse:hasUsedText forQuestion:[self question]];
	
	NSString* segueName;
	if([[hasUsedText lowercaseString] isEqualToString:@"yes"])
	{
		segueName = @"goToQ2a";
	}
	else
	{
		segueName = @"goToQ2b";
	}
	
	[self performSegueWithIdentifier:segueName sender:self];
}

@end
