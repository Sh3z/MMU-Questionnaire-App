//
//  SettingsTableViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "Settings.h"
#import "CoreDataAssistant.h"

@interface SettingsTableViewController ()
{
	/// Contains a reference to the application's settings object.
	Settings* _settings;
	
	/// Contains a reference to the switch used to indicate if a passcode should be used.
	UISwitch* _usePasscodeSwitch;
}

@end

@implementation SettingsTableViewController

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    return self = [super initWithStyle:style];
}

- (void)viewDidLoad
{
	_settings = [[CoreDataAssistant instance] getSettings];
	_usePasscodeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch(section)
	{
		case 0:
			return 1;
			
		default:
			return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
    
	if(delegate)
	{
		switch(indexPath.section)
		{
			case 0:
				[self populatePasscodeSettings:cell forRow:indexPath.row];
				break;
		}
	}
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch(section)
	{
		case 0:
			return @"Passcode";
			
		default:
			return @"";
	}
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


#pragma mark - Additional Methods

- (void)populatePasscodeSettings:(UITableViewCell*)cell forRow:(int)row
{
	switch(row)
	{
		case 0:
			cell.textLabel.text = @"Use Passcode";
			[_usePasscodeSwitch setOn:[[_settings usePasscode] boolValue]];
			[_usePasscodeSwitch addTarget:self action:@selector(passcodeSwitchToggled:) forControlEvents:UIControlEventValueChanged];
			cell.accessoryView = _usePasscodeSwitch;
			break;
			
		case 1:
			cell.textLabel.text = @"Passcode";
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
	}
}

- (void)passcodeSwitchToggled:(id)sender
{
	if(_usePasscodeSwitch.on == NO)
	{
		// Confirm this is a valid user by asking for the current passcode.
		UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Enter the current passcode to perform this change" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
		view.alertViewStyle = UIAlertViewStyleSecureTextInput;
		[view show];
	}
	else
	{
		// We're turning the passcode on, so just go ahead and do it.
		_settings.usePasscode = [NSNumber numberWithBool:YES];
		UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"Reminder" message:@"Current passcode is 1234" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[view show];
	}
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		// We're here after the user attempted to disable the passcode. Check the passcode matches.
		Settings* appSettings = [[CoreDataAssistant instance] getSettings];
		if([[[alertView textFieldAtIndex:0] text] isEqualToString:[appSettings passcodeAsString]])
		{
			// Passcode is correct - we can go ahead with the change.
			_settings.usePasscode = [NSNumber numberWithBool:NO];
		}
		else
		{
			// Passcode is incorrect. Untoggle the switch and alert the user.
			[_usePasscodeSwitch setOn:YES animated:YES];
			UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"Incorrect Passcode" message:@"The entered passcode is incorrect. The settings have not been changed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[view show];
		}
	}
	else
	{
		// The user hit cancel. Keep the passcode on.
		[_usePasscodeSwitch setOn:YES animated:YES];
	}
}


#pragma mark - SettingsTableViewController Implementation

- (IBAction)donePressed:(id)sender
{
	[delegate didFinishChangingSettings];
}

@end
