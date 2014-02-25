//
//  QuestionnaireResponseBuilder.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionnaireResponseBuilder.h"
#import "QuestionnaireApp.h"
#import "QuestionnaireResponse.h"
#import "QuestionResponse.h"
#import "CoreDataAssistant.h"
#import "LocationAssistant.h"

@interface QuestionnaireResponseBuilder ()
{
	NSDate* _startTime, *_endTime;
	NSMutableSet* _responses;
	int _currentQuestion;
}

@end

@implementation QuestionnaireResponseBuilder

- (id)init
{
	if(self = [super init])
	{
		_responses = [[NSMutableSet alloc] init];
		_startTime = [[NSDate alloc] init];
		_currentQuestion = 0;
	}
	
	return self;
}

#pragma mark - Properties

@synthesize forename, surname, dateOfBirth;


#pragma mark - Methods

- (void)appendResponse:(NSString*)response forQuestion:(NSString*)question
{
	QuestionResponse* qResponse = [[CoreDataAssistant instance] createQuestionResponse];
	[qResponse setValue:question forKey:@"question"];
	[qResponse setValue:response forKey:@"response"];
	[qResponse setValue:[NSNumber numberWithInt:_currentQuestion] forKey:@"questionNum"];
	[_responses addObject:qResponse];
	_currentQuestion++;
}

- (void)createAndStore
{
	_endTime = [[NSDate alloc] init];
	
	QuestionnaireResponse* response = [[CoreDataAssistant instance] createQuestionnaireResponse];
	
	// Create and add all the response information.
	ResponseInformation* info = [[CoreDataAssistant instance] createResponseInformation];
	[info setValue:forename forKey:@"respondantForename"];
	[info setValue:surname forKey:@"respondantSurname"];
	[info setValue:dateOfBirth forKey:@"respondantDateOfBirth"];
	[info setValue:_startTime forKey:@"timeBegan"];
	[info setValue:_endTime forKey:@"timeCompleted"];
	[info setValue:[[LocationAssistant instance] lastLocation] forKey:@"locationQuestioned"];
	[response setResponseDetails:info];
	
	// Add all the responses.
	[response addQuestionResponses:_responses];
	
	// Finally add this response into the app. store and save the context.
	[[[CoreDataAssistant instance] getApplicationStore] addResponsesObject: response];
	[[CoreDataAssistant instance] saveContext];
}

@end
