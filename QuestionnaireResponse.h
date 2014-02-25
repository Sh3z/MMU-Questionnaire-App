//
//  QuestionnaireResponse.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionResponse, QuestionnaireApp, ResponseInformation;

@interface QuestionnaireResponse : NSManagedObject

@property (nonatomic, retain) QuestionnaireApp *model;
@property (nonatomic, retain) NSSet *questionResponses;
@property (nonatomic, retain) ResponseInformation *responseDetails;
@end

@interface QuestionnaireResponse (CoreDataGeneratedAccessors)

- (void)addQuestionResponsesObject:(QuestionResponse *)value;
- (void)removeQuestionResponsesObject:(QuestionResponse *)value;
- (void)addQuestionResponses:(NSSet *)values;
- (void)removeQuestionResponses:(NSSet *)values;

@end
