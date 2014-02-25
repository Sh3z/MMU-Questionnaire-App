//
//  LocationAssistant.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "LocationAssistant.h"

@interface LocationAssistant ()
{
	CLLocationManager* _locationManager;
}

@end

@implementation LocationAssistant

#pragma mark - LocationAssistant Implementation

@synthesize lastLocation = _lastLocation;

- (id)init
{
	if(self = [super init])
	{
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	}
	
	return self;
}

+ (LocationAssistant*)instance
{
	static LocationAssistant* theInstance;
	@synchronized(self)
	{
		if(!theInstance)
		{
			theInstance = [[LocationAssistant alloc] init];
		}
	}
	
	return theInstance;
}

- (void)beginTracking
{
	if([CLLocationManager locationServicesEnabled])
	{
		[_locationManager startUpdatingLocation];
	}
}

- (void)stopTracking
{
	[_locationManager stopUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate Implementation

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"LocationAssistant reported location update failure: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	_lastLocation = [locations objectAtIndex:locations.count - 1];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"updatedLocation" object:self];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	if(status == kCLAuthorizationStatusAuthorized)
	{
		[self beginTracking];
	}
	else if(status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)
	{
		[self stopTracking];
	}
}

@end
