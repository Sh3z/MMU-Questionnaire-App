//
//  Settings.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestionnaireApp;

/// Contains the application settings.
@interface Settings : NSManagedObject

/// Contains whether a passcode is in use to protect the responses.
@property (nonatomic, retain) NSNumber * usePasscode;

/// Contains the current passcode as a string.
@property (nonatomic, retain) NSString * passcodeAsString;

/// Contains a reference to the containing QuestionnaireApp.
@property (nonatomic, retain) QuestionnaireApp *app;

@end
