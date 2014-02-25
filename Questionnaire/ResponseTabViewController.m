//
//  ResponseViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "ResponseTabViewController.h"
#import "ResponseInformation.h"
#import "ResponsesTableViewController.h"
#import "ResponsesMapAssistant.h"
#import "StatisticsViewController.h"
#import "StatisticsViewDataSource.h"

@interface ResponseTabViewController ()
{
	/// Contains a reference to the nested navigation controller.
	UINavigationController* _navigationController;
	
	/// Contains a reference to the view controller providing statistics when no response is selected
	StatisticsViewController* _statsView;
	
	/// Contains a weak reference to the popover control.
	__weak UIPopoverController* _popover;
}

@end

@implementation ResponseTabViewController

@synthesize responseView, response = _response;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)awakeFromNib
{
	// As we can't specify all the views within the nav. controllers in the storyboard, we
	// load and set them here.
	_statsView = [self.storyboard instantiateViewControllerWithIdentifier:@"noResponseView"];
	responseView = [self.storyboard instantiateViewControllerWithIdentifier:@"responseView"];
	
	// Unhiding the view causes it to load eagerly, and will actually display the details of the
	// first selected response.
	responseView.view.hidden = NO;
	
	// Provide the stats view with the data source
	_statsView.dataSource = [[StatisticsViewDataSource alloc] init];
	
	// Subscribe to the notification from the root tab view
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRecieveResponseSelectedNotification:) name:@"didSelectResponseOnMap" object:nil];
}

- (void)viewDidLoad
{
	self.navigationItem.title = @"Response Statistics";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([[segue identifier] isEqualToString:@"showResponses"])
	{
		_popover = [(UIStoryboardPopoverSegue*)segue popoverController];
		ResponsesTableViewController* vc = (ResponsesTableViewController*)[[(UINavigationController*)[_popover contentViewController] viewControllers] objectAtIndex:0];
		vc.delegate = self;
	}
	else if([[segue identifier] isEqualToString:@"embeddedView"])
	{
		_navigationController = (UINavigationController*)[segue destinationViewController];
		_navigationController.viewControllers = [NSArray arrayWithObjects:_statsView, responseView, nil];
		
		if([responseView response] == nil)
		{
			[_navigationController popToRootViewControllerAnimated:NO];
		}
	}
}


#pragma mark - ResponseTabViewController Implementation

- (IBAction)showResponsesTapped:(id)sender
{
	// If the popover isn't displayed, show it. Otherwise, dismiss it.
	if(_popover)
	{
		[_popover dismissPopoverAnimated:YES];
	}
	else
	{
		[self performSegueWithIdentifier:@"showResponses" sender:self];
	}
}

- (IBAction)exportResponseTapped:(id)sender
{
	UIGraphicsBeginImageContext(_navigationController.view.frame.size);
	[_navigationController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	NSData* imgData = UIImagePNGRepresentation(img);
	
	MFMailComposeViewController* mc = [[MFMailComposeViewController alloc] init];
	mc.mailComposeDelegate = self;
	
	if(_response)
	{
		[mc setSubject:[NSString stringWithFormat:@"Questionnaire Response (ID: %@)", [[_response responseDetails] respondantIdentifier]]];
	}
	else
	{
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		[mc setSubject:[NSString stringWithFormat:@"Questionnaire statistics as of %@", [formatter stringFromDate:[NSDate date]]]];
	}
	
	[mc addAttachmentData:imgData mimeType:@"image/png" fileName:@"response.png"];
	[self presentViewController:mc animated:YES completion:nil];
}

- (void)setResponse:(QuestionnaireResponse *)response
{
	_response = response;
	if(_response)
	{
		ResponseInformation* info = [_response responseDetails];
		NSString *identifier = [info respondantIdentifier];
		self.navigationItem.title = [NSString stringWithFormat: @"Viewing Response from ID %@", identifier];
		
		if([responseView response] == nil)
		{
			// No response is currently displayed - push the correct view in.
			[_navigationController pushViewController:responseView animated:NO];
		}
	}
	else
	{
		[_navigationController popToRootViewControllerAnimated:NO];
		self.navigationItem.title = @"Response Statistics";
	}
	
	[responseView setResponse:response];
}


#pragma mark - ResponsesDelegate Implementation

- (void)didSelectResponse:(QuestionnaireResponse*)response
{
	[self setResponse:response];
	[_popover dismissPopoverAnimated:YES];
}

- (void)didRequestStatistics
{
	[_navigationController popToRootViewControllerAnimated:NO];
	[_popover dismissPopoverAnimated:YES];
	self.navigationItem.title = @"Response Statistics";
	[responseView setResponse:nil];
	_response = nil;
}

- (void)didRecieveResponseSelectedNotification:(NSNotification*)notification
{
	[self setResponse:(QuestionnaireResponse*)notification.object];
	[self.tabBarController setSelectedIndex:1];
}


#pragma mark - MFMailComposeViewControllerDelegate Implementation

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
