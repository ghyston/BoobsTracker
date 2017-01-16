//
//  FeedRecord+CoreDataProperties.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 15/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FeedRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedRecord> {
        return NSFetchRequest<FeedRecord>(entityName: "FeedRecord");
    }

    @NSManaged public var isLeft: Bool
    @NSManaged public var feedTime: NSDate?

}
