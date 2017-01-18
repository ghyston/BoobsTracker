//
//  FeedRecord+CoreDataProperties.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 18/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import Foundation
import CoreData


extension FeedRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedRecord> {
        return NSFetchRequest<FeedRecord>(entityName: "FeedRecord");
    }

    @NSManaged public var feedTime: NSDate?
    @NSManaged public var isLeft: Bool
    @NSManaged public var sectionIdentifier: String?

}
