//
//  StatisticsViewController.m
//  Questionnaire
//
//  Created by Thomas Sherwood on 03/12/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import "StatisticsViewController.h"
#import "XYPieChart.h"
#import "CoreDataAssistant.h"
#import "QuestionnaireApp.h"
#import "iPadUsagePieChartDataSource.h"
#import "DifficultyPieChartDataSource.h"

@interface StatisticsViewController ()
{
	/// Contains the data source for the usages chart
	iPadUsagePieChartDataSource* _usageSource;
	
	/// Contains the data source for the difficulties chart
	DifficultyPieChartDataSource* _difficultySource;
	
	/// Contains the iPad usage chart
	XYPieChart* _usageChart;
	
	/// Contains the difficulty chart
	XYPieChart* _difficultyChart;
	
	/// Contains the string used for the usedBeforeLabel
	NSString* _usedBeforeString;
	
	/// Contains the string used for the wouldUseAgainLabel
	NSString* _useAgainString;
	
	/// Contains the string used for the hadDifficultyButWouldUseAgainLabel
	NSString* _hadDifficultyString;
}

@end

@implementation StatisticsViewController

@synthesize totalRespondantsLabel, usedBeforeLabel, wouldUseAgainLabel, hadDifficultyButWouldUseAgainLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	_usedBeforeString = @"%i%% of respondants (%i) have used an iPad before";
	_useAgainString = @"%i%% of respondants (%i) would use an iPad again";
	_hadDifficultyString = @"%i%% of respondants (%i) who found using an iPad difficult would use an iPad again";
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.navigationController setTitle:@"Response Statistics"];
	[self.dataSource updateStatistics:[[CoreDataAssistant instance] getApplicationStore]];
	[self updateLabels];
	[_usageChart reloadData];
	[_difficultyChart reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([[segue identifier] isEqualToString:@"usagesChart"])
	{
		_usageSource = [[iPadUsagePieChartDataSource alloc] init];
		_usageChart = (XYPieChart*)[[segue destinationViewController] view];
		_usageChart.dataSource = _usageSource;
		[self prepareChartView:_usageChart];
	}
	else if([[segue identifier] isEqualToString:@"difficultyChart"])
	{
		_difficultySource = [[DifficultyPieChartDataSource alloc] init];
		_difficultyChart = (XYPieChart*)[[segue destinationViewController] view];
		_difficultyChart.dataSource = _difficultySource;
		[self prepareChartView:_difficultyChart];
	}
}


#pragma mark - Additional Methods

- (void)hideComponents:(BOOL)hide
{
	for(UIView* view in [[self view] subviews])
	{
		if(view != totalRespondantsLabel)
		{
			view.hidden = hide;
		}
	}
}

/// Ensures the labels are up to date.
- (void)updateLabels
{
	switch([self.dataSource numberOfResponses])
	{
		case 0:
			[self.totalRespondantsLabel setText:@"No responses have been collected."];
			[self hideComponents: YES];
			break;
			
		case 1:
			[self.totalRespondantsLabel setText:@"One response has been collected."];
			[self hideComponents:NO];
			break;
			
		default:
			[self.totalRespondantsLabel setText:[NSString stringWithFormat:@"A total of %i responses has been collected so far.", [self.dataSource numberOfResponses]]];
			[self hideComponents:NO];
			break;
	}

	[self.usedBeforeLabel setText:[NSString stringWithFormat:_usedBeforeString, [self.dataSource usediPadBeforePercentage], [self.dataSource numberUsediPadBefore]]];
	[self.wouldUseAgainLabel setText:[NSString stringWithFormat:_useAgainString, [self.dataSource wouldUseiPadAgainPercentage], [self.dataSource numberWouldUseiPadAgain]]];
	[self.hadDifficultyButWouldUseAgainLabel setText:[NSString stringWithFormat:_hadDifficultyString, [self.dataSource hadDifficultyButWouldUseiPadAgainPercentage], [self.dataSource numberHadDifficultyButWouldUseiPadAgain]]];
}

/**
 * Prepares a chart view prior to initial display
 * @param chart the XYPieChart to prepare for display
 */
- (void)prepareChartView:(XYPieChart*)chart
{
	[chart setShowPercentage:NO];
	[chart setPieRadius:chart.bounds.size.width * 0.20];
}

@end
