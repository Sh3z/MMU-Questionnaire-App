//
//  WouldUseAgainViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "WouldUseAgainViewController.h"

@implementation WouldUseAgainViewController

#pragma mark - Overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (NSString*)question
{
	return @"Would you consider using an iPad again in the future?";
}

- (void)responsePressed:(UIButton *)button
{
	[self.builder appendResponse:[[button titleLabel] text] forQuestion:[self question]];
	[self.builder createAndStore];
	[self performSegueWithIdentifier:@"goToComplete" sender:self];
}

@end
