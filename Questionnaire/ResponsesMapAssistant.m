//
//  ResponsesMapAssistant.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 28/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "ResponsesMapAssistant.h"
#import "QuestionnaireResponse.h"
#import "ResponsePairing.h"
#import "ResponseInformation.h"

@interface ResponsesMapAssistant ()
{
	/// Retains a reference to the buttons and their annotations for later tracking and event firing.
	NSMutableArray* _annotationMap;
	
	/// Indicates whether the map view has zoomed in on the user's current location during initialization.
	BOOL _didInitialUserZoom;
}

@end

@implementation ResponsesMapAssistant

#pragma mark - Properties

@synthesize responses = _responses, map = _map, delegate;

- (void)setMap:(MKMapView *)map
{
	if(_map)
	{
		_map.delegate = nil;
	}
	
	_map = map;
	if(_map)
	{
		_map.delegate = self;
	}
}

- (void)setResponses:(NSArray *)responses
{
	[self clearMap];
	_responses = responses;
	_annotationMap = [[NSMutableArray alloc] initWithCapacity:[responses count]];
	if(_map && _responses)
	{
		[self addResponsesToMap:_responses];
	}
}


#pragma mark - Methods

- (void)clearMap
{
	// Remove everything except the current user location pin.
	id userLoc = [_map userLocation];
	NSMutableArray* locations = [[NSMutableArray alloc] initWithArray:[_map annotations]];
	if(userLoc)
	{
		[locations removeObject:userLoc];
	}
	
	[_map removeAnnotations:locations];
}

- (void)refreshMap
{
	[self clearMap];
	
	// Now add the responses we've been given.
	[self addResponsesToMap:_responses];
}

- (void)zoomOnLastAddedAnnotation
{
	QuestionnaireResponse* lastResponse = [_responses lastObject];
	CLLocationCoordinate2D coord = [[[lastResponse responseDetails] locationQuestioned] coordinate];
	[self zoomToCoordinate:coord];
}

- (void)zoomOnUserLocation
{
	[self zoomToCoordinate:[[_map userLocation] coordinate]];
}

/**
 * Zooms the map onto the coordinate to focus it in the view
 * @param coord the position the move the map.
 */
- (void)zoomToCoordinate:(CLLocationCoordinate2D)coord
{
	MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coord, 100, 100);
	MKCoordinateRegion adjusted = [self.map regionThatFits:viewRegion];
	[self.map setRegion:adjusted animated:YES];
}

/**
 * Adds the responses within the provided array to the map.
 * @param responses - the set of responses to add to the map.
 */
- (void)addResponsesToMap:(NSArray*)responses
{
	for(QuestionnaireResponse* response in responses)
	{
		[_map addAnnotation:response];
	}
}


#pragma mark - MKMapViewDelegate Implementation

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if([annotation isKindOfClass:[QuestionnaireResponse class]])
	{
		static NSString* annotationIdentifier = @"questionnaireAnnotation";
		MKAnnotationView* view = [_map dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
		
		UIButton* disclosure;
		if(!view)
		{
			view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
			view.image = [UIImage imageNamed:@"MapNotification.png"];
			view.centerOffset = CGPointMake(0, -1 * (view.image.size.height / 2));
			view.canShowCallout = YES;
			
			// If we have a delegate, allow the tapping of annotations.
			if(delegate)
			{
				disclosure = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
				UITapGestureRecognizer* tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(annotationTapped:)];
				tapper.numberOfTapsRequired = 1;
				[disclosure addGestureRecognizer:tapper];
				view.rightCalloutAccessoryView = disclosure;
			}
		}
		else
		{
			disclosure = (UIButton*)view.rightCalloutAccessoryView;
			view.annotation = annotation;
		}
		
		// Retain the pairing for future lookup.
		ResponsePairing* pair = [[ResponsePairing alloc] init];
		pair.button = disclosure;
		pair.annotation = annotation;
		[_annotationMap addObject:pair];
		
		return view;
	}
	else
	{
		return nil;
	}
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	if(!_didInitialUserZoom)
	{
		_didInitialUserZoom = YES;
		[self zoomOnUserLocation];
	}
}


#pragma mark - Additional Methods

- (void)annotationTapped:(UIGestureRecognizer*)recognizer
{
	if(delegate)
	{
		// Get the button for the recognizer.
		ResponsePairing* thePair;
		UIButton* theButton = (UIButton*)recognizer.view;
		for(ResponsePairing* pair in _annotationMap)
		{
			if(pair.button == theButton)
			{
				thePair = pair;
				break;
			}
		}
		
		if(thePair)
		{
			[delegate didRequestDisplayOfResponse:[thePair annotation]];
		}
	}
}

@end
