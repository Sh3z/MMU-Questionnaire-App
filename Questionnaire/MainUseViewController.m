//
//  MainUseViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "MainUseViewController.h"

@implementation MainUseViewController

#pragma mark - Overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (NSString*)question
{
	return @"What is your main use of the iPad?";
}

- (void)responsePressed:(UIButton *)button
{
	[self.builder appendResponse:[[[button titleLabel] text] stringByReplacingOccurrencesOfString:@"\n" withString:@""] forQuestion:[self question]];
	[self performSegueWithIdentifier:@"goToQ3From2a" sender:self];
}

@end
