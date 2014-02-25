//
//  QuestionnaireResponse.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionnaireResponse.h"
#import "QuestionResponse.h"
#import "QuestionnaireApp.h"
#import "ResponseInformation.h"
#import <CoreLocation/CoreLocation.h>


@implementation QuestionnaireResponse

@dynamic model;
@dynamic questionResponses;
@dynamic responseDetails;


#pragma mark - MKAnnotation Implementation

- (CLLocationCoordinate2D)coordinate
{
	return [[[self responseDetails] locationQuestioned] coordinate];
}

- (NSString*)title
{
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	ResponseInformation* info = [self responseDetails];
	return [NSString stringWithFormat:@"Acquired on %@", [formatter stringFromDate:[info timeBegan]]];
}

@end
