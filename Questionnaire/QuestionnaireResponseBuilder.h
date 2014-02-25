//
//  QuestionnaireResponseBuilder.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 20/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 * Represents a builder used in the construction of a response from an ongoing Questionnaire.
 */
@interface QuestionnaireResponseBuilder : NSObject

#pragma mark - Properties

/// Gets or sets the forename of the respondee.
@property (nonatomic, strong) NSString* forename;

/// Gets or sets the surname of the respondee.
@property (nonatomic, strong) NSString* surname;

/// Gets or sets the date of birth of the respondee.
@property (nonatomic, strong) NSDate* dateOfBirth;


#pragma mark - Methods

/**
 * Stores the response of a question from the Questionnaire.
 * @param response the answer provided by the Questionee.
 * @param question the question proposed to the Questionee.
 */
- (void)appendResponse:(NSString*)response forQuestion:(NSString*)question;

/**
 * Creates and stores a new QuestionnaireResponse using the information from this builder.
 */
- (void)createAndStore;


@end
