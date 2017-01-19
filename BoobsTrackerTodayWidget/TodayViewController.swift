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

class TodayViewController: UIViewController, NCWidgetProviding, FeedRecorder {
    
    @IBOutlet weak var lastRecordLabel: UILabel!
    
    @IBAction func onLeftCLick(_ sender: Any)
    {
        saveRecord(isLeft: true)
    }
    
    @IBAction func onRightClick(_ sender: Any)
    {
        saveRecord(isLeft: false)
    }
    
    var lastFeed : FeedRecord! = nil
        {
        didSet{
            updateLabel()
        }
    }
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
        
        print("widgetPerformUpdate")
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func queryLastFeed()
    {
        
        let stack = CoreDataStack.shared
        
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
        }
    }
    
    func updateLabel()
    {
        updateLabel(lastFeed: lastFeed, label: lastRecordLabel)
    }
    
    private func saveRecord(isLeft : Bool)
    {
        let stack = CoreDataStack.shared
        self.lastFeed = FeedRecord(isLeft: isLeft, context: stack.context)
        do {
            try stack.saveContext()
        } catch {
            print("Error while autosaving")
        }
    }
    
}
