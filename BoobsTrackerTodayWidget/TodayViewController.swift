//
//  TodayViewController.swift
//  BoobsTrackerTodayWidget
//
//  Created by Ilja Stepanow on 18/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        queryLastFeed()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func queryLastFeed()
    {
        /*let app = UIApplication.shared.delegate as! AppDelegate
        let stack = app.stack
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedRecord")
        fr.sortDescriptors = [NSSortDescriptor(key: "feedTime", ascending: false)]
        fr.fetchLimit = 1
        
        do{
            let records = try stack.context.fetch(fr) as! [FeedRecord]
            self.lastFeed = records.first
        }
        catch
        {
            print ("Exception during perform fetching")
            
        }*/
    }
    
}
