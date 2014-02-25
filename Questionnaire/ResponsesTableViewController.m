//
//  ResponsesTableViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "ResponsesTableViewController.h"
#import "CoreDataAssistant.h"
#import "QuestionnaireApp.h"
#import "QuestionnaireResponse.h"

@interface ResponsesTableViewController ()
{
	/// Stores all responses from the model to save on fetch requests.
	NSArray* _allResponses;
	
	/// Stores the responses matching the search criteria
	NSMutableArray* _filteredResponses;
	
	/// If YES, the table view is currently being filtered.
	BOOL _isFiltered;
}

@end

@implementation ResponsesTableViewController

@synthesize delegate, searchBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    return self = [super initWithStyle:style];
}

- (void)viewWillAppear:(BOOL)animated
{
	// Ensure the responses are up to date
	_allResponses = [[[[CoreDataAssistant instance] getApplicationStore] responses] allObjects];
}

- (void)viewDidLoad
{
	searchBar.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[delegate didSelectResponse:[self responseAtRow:indexPath.row]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(_isFiltered)
	{
		return [_filteredResponses count];
	}
	else
	{
		return [_allResponses count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"responseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
	
	QuestionnaireResponse* response = [self responseAtRow:indexPath.row];
	cell.textLabel.text = [[response responseDetails] respondantIdentifier];
	cell.imageView.image = nil;
	cell.indentationWidth = 0;
	
	if([[[response responseDetails] hasSeen] isEqualToNumber:[NSNumber numberWithBool:NO]])
	{
		cell.imageView.image = [UIImage imageNamed:@"Exclaim"];
	}
	else
	{
		cell.indentationWidth = 25.0f;
	}
	
    return cell;
}

- (IBAction)didRequestStatisticsView:(id)sender
{
	[self.delegate didRequestStatistics];
}


#pragma mark - UISearchBarDelegate Implementation

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if([searchText length] == 0)
	{
		_isFiltered = NO;
		_filteredResponses = nil;
	}
	else
	{
		_isFiltered = YES;
		[self updateFilterForInput:searchText];
	}
	
	[self.tableView reloadData];
}


#pragma mark - Additional Methods

/**
 * Gets the QuestionnaireResponse in the table at the moment, at the given roe
 * @param row the row within the table to retrieve the response from
 * @return the QuestionnaireResponse currently displayed within the table at the current row
 */
- (QuestionnaireResponse*)responseAtRow:(int)row
{
	NSArray* collectionInUse = _isFiltered ? _filteredResponses : _allResponses;
	return [collectionInUse objectAtIndex:row];
}

/**
 * Updates the _filteredResponses object with items matching the input term
 * @param searchText the input term from the user
 */
- (void)updateFilterForInput:(NSString *)searchText
{
	if(!_filteredResponses)
	{
		_filteredResponses = [[NSMutableArray alloc] init];
	}
	else
	{
		[_filteredResponses removeAllObjects];
	}
	
	for(QuestionnaireResponse* response in _allResponses)
	{
		ResponseInformation* info = [response responseDetails];
		NSString* respondantID = [info respondantIdentifier];
		NSRange range = [respondantID rangeOfString:searchText options:NSCaseInsensitiveSearch];
		if(range.location != NSNotFound)
		{
			[_filteredResponses addObject:response];
		}
	}
}

@end
