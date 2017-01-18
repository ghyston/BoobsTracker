//
//  FeedRecord+CoreDataClass.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 18/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import Foundation
import CoreData

@objc(FeedRecord)
public class FeedRecord: NSManagedObject {
    
    convenience init(isLeft:Bool, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "FeedRecord", in: context)
        {
            self.init(entity: ent, insertInto: context)
            self.isLeft = isLeft
            self.feedTime = NSDate()
            self.sectionIdentifier = DateFormatter.localizedString(
                from: self.feedTime as! Date,
                dateStyle: DateFormatter.Style.long,
                timeStyle: DateFormatter.Style.none)
        }
        else
        {
            fatalError("Unable to find entity name!")
        }
    }

}
