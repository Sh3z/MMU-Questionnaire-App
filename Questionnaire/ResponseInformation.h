//
//  ResponseInformation.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 25/02/2014.
//  Copyright (c) 2014 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireResponse;

@interface ResponseInformation : NSManagedObject

@property (nonatomic, retain) NSNumber * hasSeen;
@property (nonatomic, retain) id locationQuestioned;
@property (nonatomic, retain) NSDate * respondantDateOfBirth;
@property (nonatomic, retain) NSDate * timeBegan;
@property (nonatomic, retain) NSDate * timeCompleted;
@property (nonatomic, retain) NSString * respondantIdentifier;
@property (nonatomic, retain) QuestionnaireResponse *response;

@end
