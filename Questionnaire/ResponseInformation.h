//
//  ResponseInformation.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireResponse;

/// Encapsulates the metadata of a Questionnaire response
@interface ResponseInformation : NSManagedObject

/// Contains the location the Questionnaire was undertaken. This is a CLLocation object.
@property (nonatomic, retain) id locationQuestioned;

/// Contains the date of birth of the respondant.
@property (nonatomic, retain) NSDate * respondantDateOfBirth;

/// Contains the respondants forename.
@property (nonatomic, retain) NSString * respondantForename;

/// Contains the respondants surname.
@property (nonatomic, retain) NSString * respondantSurname;

/// Contains the time the user began the Questionnaire.
@property (nonatomic, retain) NSDate * timeBegan;

/// Contains the time the user completed the questionnaire.
@property (nonatomic, retain) NSDate * timeCompleted;

/// Contains a BOOL value indicating whether the response has been viewed.
@property (nonatomic, retain) NSNumber * hasSeen;

/// Contains a reference to the containing QuestionnaireResponse object.
@property (nonatomic, retain) QuestionnaireResponse *response;

@end
