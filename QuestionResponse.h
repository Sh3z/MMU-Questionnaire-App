//
//  QuestionResponse.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 28/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireResponse;

/// Represents a single response to a question from the Questionnaire.
@interface QuestionResponse : NSManagedObject

/// Contains the question proposed to the user.
@property (nonatomic, retain) NSString * question;

/// Contains the response obtained from the user.
@property (nonatomic, retain) NSString * response;

/// Contains a number identifying which question this object is representing within a response.
@property (nonatomic, retain) NSNumber * questionNum;

/// Contains the parent questionnaire response object.
@property (nonatomic, retain) QuestionnaireResponse *parentResponse;

@end
