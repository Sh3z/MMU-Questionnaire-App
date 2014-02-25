//
//  ResponsesTableViewController.h
//  Questionnaire
//
//  Created by Thomas Sherwood on 21/11/2013.
//  Copyright (c) 2013 Thomas Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseTabViewController.h"
#import "ResponsesDelegate.h"

/// Represents the view-controller that lists all gathered responses.
@interface ResponsesTableViewController : UITableViewController<UISearchBarDelegate>

/// Contains a reference to a delegate object awaiting the selection of a Questionnaire response.
@property (nonatomic, strong) NSObject<ResponsesDelegate>* delegate;

/// Contains a reference to the responses search bar.
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

/**
 * Occurs when the user requests the statistics to be displayed again.
 * @param sender the object that caused this call.
 */
- (IBAction)didRequestStatisticsView:(id)sender;

@end
