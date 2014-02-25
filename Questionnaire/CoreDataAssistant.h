//
//  CoreDataAssistant.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "QuestionResponse.h"
#import "QuestionnaireResponse.h"
#import "ResponseInformation.h"
#import "Settings.h"

/// Represents the singleton providing access to the core data layer.
@interface CoreDataAssistant : NSObject

#pragma mark - Properties

/// Returns the managed object context for the application.
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/// Returns the managed object model for the application.
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

/// Returns the persistent store coordinator for the application.
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/// Returns the URL to the application's Documents directory.
@property (readonly, strong, nonatomic) NSURL* applicationDocumentsDirectory;


#pragma mark - Singleton

/**
 * Gets the singleton core data instance.
 * @return the singleton instance.
 */
+ (CoreDataAssistant*)instance;


#pragma mark - Factory Methods

/**
 * Retrieves the QuestionnaireApp object from the data store. If it does not
 * exist, it is created.
 * @return the QuestionnaireApp used by the app.
 */
- (QuestionnaireApp*)getApplicationStore;

/**
 * Retrieves the Settings object from the data store. If it does not exist, it
 * is created
 * @return the Settings object used by the app
 */
- (Settings*)getSettings;

/**
 * Creates and returns a new managed QuestionnaireResponse instance.
 * @return a new QuestionnaireResponse object.
 */
- (QuestionnaireResponse*)createQuestionnaireResponse;

/**
 * Creates and returns a new managed QuestionResponse instance.
 * @return a new QuestionResponse object.
 */
- (QuestionResponse*)createQuestionResponse;

/**
 * Creates and returns a new managed ResponseInformation instance.
 * @return a new ResponseInformation instance.
 */
- (ResponseInformation*)createResponseInformation;


#pragma mark - Methods

/// Saves any changes to the Core Data context.
- (void)saveContext;

@end
