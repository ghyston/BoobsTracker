//
//  ActivityListViewController.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 15/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import UIKit
import CoreData

class ActivityListViewController : CoreDataTableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title
        title = "Recent activity"
        
        // Get the stack
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        // Create a fetchrequest
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedRecord")
        fr.sortDescriptors = [NSSortDescriptor(key: "feedTime", ascending: false)]
        
        //@todo: limit for last 24 hours!
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Find the right notebook for this indexpath
        let feedRecord = fetchedResultsController!.object(at: indexPath) as! FeedRecord
        
        // Create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedRecordTableCell", for: indexPath)
        
        // Sync notebook -> cell
        cell.textLabel?.text = DateFormatter.localizedString(
            from: feedRecord.feedTime as! Date,
            dateStyle: DateFormatter.Style.medium,
            timeStyle: DateFormatter.Style.medium)
        
        let leftColor = UIColor(red: 0.47, green: 0.46, blue: 0.67, alpha: 1.0)
        let rightColor = UIColor(red: 0.69, green: 0.33, blue: 0.26, alpha: 1.0)
        
        cell.detailTextLabel?.textColor = feedRecord.isLeft ? leftColor : rightColor
        cell.detailTextLabel?.text = feedRecord.isLeft ? "Left" : "Right"
        
        return cell
    }    
}
