//
//  QuestionnaireApp.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireResponse, Settings;

/// Represents the containing data store within the application.
@interface QuestionnaireApp : NSManagedObject

/// Contains all the responses collected through use of the application.
@property (nonatomic, retain) NSSet *responses;

/// Contains the user preferences for the application.
@property (nonatomic, retain) Settings *settings;
@end

@interface QuestionnaireApp (CoreDataGeneratedAccessors)

- (void)addResponsesObject:(QuestionnaireResponse *)value;
- (void)removeResponsesObject:(QuestionnaireResponse *)value;
- (void)addResponses:(NSSet *)values;
- (void)removeResponses:(NSSet *)values;

@end
