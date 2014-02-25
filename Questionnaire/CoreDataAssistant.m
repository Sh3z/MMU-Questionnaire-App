//
//  CoreDataAssistant.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "CoreDataAssistant.h"

@implementation CoreDataAssistant

#pragma mark - Properties

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
	{
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.xcdatamodeld"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
	{
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


#pragma mark - Singleton

+ (CoreDataAssistant*)instance
{
	static CoreDataAssistant* theInstance;
	@synchronized(self)
	{
		if(!theInstance)
		{
			theInstance = [[CoreDataAssistant alloc] init];
		}
	}
	
	return theInstance;
}


#pragma mark - Factory Methods

- (QuestionnaireApp*)getApplicationStore
{
	NSArray* objects = [self fetchEntityWithName:@"QuestionnaireApp"];
	if(!objects)
	{
		return nil;
	}
	
	QuestionnaireApp* app;
	if([objects count] == 0)
	{
		// This is the first time the app has been run. We should create and store a new instance.
		app = (QuestionnaireApp*)[self entityForName:@"QuestionnaireApp"];
		[self saveContext];
	}
	else
	{
		app = [objects firstObject];
	}
	
	return app;
}

- (Settings*)getSettings
{
	NSArray* objects = [self fetchEntityWithName:@"Settings"];
	if(!objects)
	{
		return nil;
	}
	
	Settings* settings;
	if([objects count] == 0)
	{
		// This is the first time the app has been run. We should create and store a new instance.
		settings = (Settings*)[self entityForName:@"Settings"];
		[self saveContext];
	}
	else
	{
		settings = [objects firstObject];
	}
	
	return settings;
}

- (QuestionnaireResponse*)createQuestionnaireResponse
{
	return (QuestionnaireResponse*)[self entityForName:@"QuestionnaireResponse"];
}

- (QuestionResponse*)createQuestionResponse
{
	return (QuestionResponse*)[self entityForName:@"QuestionResponse"];
}

- (ResponseInformation*)createResponseInformation
{
	return (ResponseInformation*)[self entityForName:@"ResponseInformation"];
}


#pragma mark - Methods

- (void)saveContext
{
    NSError *error = nil;
    if(self.managedObjectContext)
	{
        if([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error])
		{
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Additional Methods

/**
 * Performs a fetch request for an entity with the given name. This traps and
 * logs any errors
 * @param entityName the name of the entity to perform a fetch request for
 * @return an NSArray of objects returned from the fetch request, or nil if an
 * error occurs.
 */
- (NSArray*)fetchEntityWithName:(NSString*)entityName
{
	NSError* error;
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
	NSArray *objects = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if(objects == nil)
	{
        NSLog(@"Error loading Settings instance: %@", error.description);
        return nil;
    }
	else
	{
		return objects;
	}
}

/**
 * Creates, inserts and returns an entity for the given name
 * @param entityName the name of the entity within the model
 * @return an NSManagedObject representing the created entity
 */
- (NSManagedObject*)entityForName:(NSString*)entityName
{
	return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
}

@end
