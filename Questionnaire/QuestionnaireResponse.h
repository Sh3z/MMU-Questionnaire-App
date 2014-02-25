//
//  QuestionnaireResponse.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class QuestionResponse, QuestionnaireApp, ResponseInformation;

/// Represents a single response to the questionnaire.
@interface QuestionnaireResponse : NSManagedObject<MKAnnotation>

/// Contains a reference to the underlying app.
@property (nonatomic, retain) QuestionnaireApp *model;

/// Contains the set of question responses.
@property (nonatomic, retain) NSSet *questionResponses;

/// Contains further metadata about this response.
@property (nonatomic, retain) ResponseInformation *responseDetails;
@end

@interface QuestionnaireResponse (CoreDataGeneratedAccessors)

- (void)addQuestionResponsesObject:(QuestionResponse *)value;
- (void)removeQuestionResponsesObject:(QuestionResponse *)value;
- (void)addQuestionResponses:(NSSet *)values;
- (void)removeQuestionResponses:(NSSet *)values;

@end
