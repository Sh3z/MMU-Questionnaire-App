//
//  QuestionnaireResponseTableViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 27/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "QuestionnaireResponseTableViewController.h"
#import "QuestionResponse.h"
#import "ResponseInformation.h"

@interface QuestionnaireResponseTableViewController ()
{
	/// Contains a set of the question responses from the current questionnaire response.
	NSArray* _questionResponses;
}

@end

@implementation QuestionnaireResponseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
	{
        // Custom initialization
    }
	
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
	{
		return 5;
	}
	else
	{
		return [_questionResponses count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
	
	if(indexPath.section == 1)
	{
		[self populateCellForQuestion:indexPath cell:cell];
	}
	else
	{
		[self populateRespondantInformation:cell indexPath:indexPath];
	}
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == 0)
	{
		return @"Respondant Data";
	}
	else
	{
		return @"Question Responses";
	}
}


#pragma mark - QuestionResponsesViewController Implementation

@synthesize questionnaireResponse = _questionnaireResponse;

- (void)setQuestionnaireResponse:(QuestionnaireResponse *)questionResponse
{
	_questionnaireResponse = questionResponse;
	_questionResponses = [[_questionnaireResponse questionResponses] allObjects];
	[self.tableView reloadData];
}


#pragma mark - Additional Methods

/**
 * Populates a table cell with the information about the respondant
 * @param indexPath the section and row information for the cell.
 */
- (void)populateRespondantInformation:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
	ResponseInformation* info = [_questionnaireResponse responseDetails];
	NSDateFormatter* formatter;
	NSTimeInterval timeTaken;
	switch(indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Identifier";
			cell.detailTextLabel.text = [info respondantIdentifier];
			break;
			
		case 1:
			formatter = [[NSDateFormatter alloc] init];
			[formatter setDateStyle:NSDateFormatterLongStyle];
			cell.textLabel.text = @"Date of Birth";
			cell.detailTextLabel.text = [formatter stringFromDate:[info respondantDateOfBirth]];
			break;
			
		case 2:
			formatter = [[NSDateFormatter alloc] init];
			[formatter setDateStyle:NSDateFormatterLongStyle];
			[formatter setTimeStyle:NSDateFormatterLongStyle];
			cell.textLabel.text = @"Acquired On";
			cell.detailTextLabel.text = [formatter stringFromDate:[info timeBegan]];
			break;
			
		case 3:
			formatter = [[NSDateFormatter alloc] init];
			[formatter setTimeStyle:NSDateFormatterLongStyle];
			cell.textLabel.text = @"Time Completed";
			cell.detailTextLabel.text = [formatter stringFromDate:[info timeCompleted]];
			break;
			
		case 4:
			timeTaken = [[info timeCompleted] timeIntervalSinceReferenceDate] - [[info timeBegan] timeIntervalSinceReferenceDate];
			cell.textLabel.text = @"Time Taken";
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%i seconds", (int)timeTaken];
			break;
	}
}

/**
 * Populates a table cell with the information retrieved for a question.
 * @param indexPath the section and row information for the cell
 * @param cell the cell to be populated.
 */
- (void)populateCellForQuestion:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
	QuestionResponse* theResponse;
	for(QuestionResponse* response in _questionResponses)
	{
		if([response questionNum] == [NSNumber numberWithInt:indexPath.row])
		{
			theResponse = response;
		}
	}
	
	if(theResponse)
	{
		cell.textLabel.text = [theResponse question];
		cell.detailTextLabel.text = [theResponse response];
	}
}

@end
