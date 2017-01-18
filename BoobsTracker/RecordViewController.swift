//
//  RecordViewController.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 15/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import UIKit
import CoreData

class RecordViewController : UIViewController
{
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var lastTimeLabel: UILabel!
    
    private var timer : Timer?

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
    
    override func viewWillAppear(_ animated : Bool)
    {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(RecordViewController.updateLabel), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
    }
    
    @IBAction func leftBtnClick(_ sender: Any)
    {
        saveRecord(isLeft: true)
    }
    
    @IBAction func rightBtnClick(_ sender: Any)
    {
        saveRecord(isLeft: false)
    }
    
    private func saveRecord(isLeft : Bool)
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        let stack = app.stack
        self.lastFeed = FeedRecord(isLeft: isLeft, context: stack.context)
        do {
            try stack.saveContext()
        } catch {
            print("Error while autosaving")
        }
        //disableButtons()
    }
    
    /*private func disableButtons()
    {
        leftButton.isHidden = true
        rightButton.isHidden = true
        
        let time = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.enableButtons()
        }
    }
    
    private func enableButtons()
    {
        leftButton.isHidden = false
        rightButton.isHidden = false
    }*/
    
    func updateLabel()
    {
        if(lastFeed == nil)
        {
            lastTimeLabel.text = "No record data yet"
            return
        }
        
        let diff : TimeInterval = NSDate ().timeIntervalSince(lastFeed.feedTime as! Date)
        
        let boldAttr = UIFont.boldSystemFont(ofSize: 17)
        
        //@todo: copypaster in storyboard & ActivityListViewController
        let leftColor = UIColor(red: 0.47, green: 0.46, blue: 0.67, alpha: 1.0)
        let rightColor = UIColor(red: 0.69, green: 0.33, blue: 0.26, alpha: 1.0)
        
        let normalTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        let timeAttributes = [NSForegroundColorAttributeName: UIColor.orange, NSFontAttributeName: boldAttr]
        let leftAttributes = [NSForegroundColorAttributeName: leftColor, NSFontAttributeName: boldAttr]
        let rightAttributes = [NSForegroundColorAttributeName: rightColor, NSFontAttributeName: boldAttr]
        
        let part1 = NSMutableAttributedString(string: "Last feed was ", attributes: normalTextAttributes)
        let part2 = NSMutableAttributedString(string: stringFromTimeInterval(diff), attributes: timeAttributes)
        let part3 = NSMutableAttributedString(string: " ago with ", attributes: normalTextAttributes)
        
        let part4 = lastFeed.isLeft ?
        NSMutableAttributedString(string: "L", attributes: leftAttributes) :
        NSMutableAttributedString(string: "R", attributes: rightAttributes)
        
        let combination = NSMutableAttributedString()
        
        combination.append(part1)
        combination.append(part2)
        combination.append(part3)
        combination.append(part4)
        
        lastTimeLabel.attributedText = combination
        
    }
    
    private func stringFromTimeInterval(_ interval: TimeInterval) -> String
    {
        let ti = NSInteger(interval)
        
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        if hours > 0
        {
            return String(format: "%dh %0.2dm",hours,minutes)
        }
        else
        {
            return String(format: "%dm", minutes)
        }
    }
    
    @IBAction func onInfoClick(_ sender: Any)
    {
        var infoText : String = "Created by Hyston \nto his lovely wife Daria"
        var nameAppStr = ""
        
        if let nameApp = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        {
            nameAppStr = nameApp
            nameAppStr.append(" app")
        }
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        {
            infoText.append("\nv")
            infoText.append(version)
        }
        
        
        let alertController = UIAlertController(title: nameAppStr, message: infoText, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        /*
         guard (self.alertController == nil) else {
         print("Alert already displayed")
         return
         }
         
         self.baseMessage = message
         self.remainingTime = time
         
         self.alertController = UIAlertController(title: title, message: self.alertMessage(), preferredStyle: .Alert)
         
         let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
         print("Alert was cancelled")
         self.alertController=nil;
         self.alertTimer?.invalidate()
         self.alertTimer=nil
         }
         
         self.alertController!.addAction(cancelAction)
         
         self.alertTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
         
         self.presentViewController(self.alertController!, animated: true, completion: nil)
        */
    }
    
    private func queryLastFeed()
    {
        let app = UIApplication.shared.delegate as! AppDelegate
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
            
        }
    }
}
