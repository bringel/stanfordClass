//
//  FlickrPhotosTableViewController.h
//  TopPlaces
//
//  Created by Brad Ringel on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhotosTableViewController : UITableViewController

@property (nonatomic, strong)NSArray *photos;
@property (nonatomic, strong)NSDictionary *place;

@end
