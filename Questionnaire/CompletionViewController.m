//
//  CompletionViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "CompletionViewController.h"

@implementation CompletionViewController

#pragma mark - Overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)responsePressed:(UIButton *)button
{
	[[self questionnaireDelegate] didCompleteQuestionnaire];
}

@end
