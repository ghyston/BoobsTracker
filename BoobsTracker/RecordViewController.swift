//
//  RecordViewController.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 15/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import UIKit
import CoreData

class RecordViewController : UIViewController, FeedRecorder
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
        fadeInLabel()
    }
    
    @IBAction func rightBtnClick(_ sender: Any)
    {
        saveRecord(isLeft: false)
        fadeInLabel()
    }
    
    private func fadeInLabel()
    {
        lastTimeLabel.alpha = 0;
        UIView.animate(withDuration: 0.5, animations: {
            self.lastTimeLabel.alpha = 1.0
        })
        
        /*
         UIView.animate(withDuration: 0.5, delay: 0.3, options: [.repeat, .curveEaseOut, .autoreverse], animations: {
         self.username.center.x += self.view.bounds.width
         }, completion: nil)
         })
         
         
        labelMain.alpha = 0;
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
            animations:^{ labelMain.alpha = 1;}
            completion:nil];*/
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
    
    func updateLabel()
    {
        updateLabel(lastFeed: lastFeed, label: lastTimeLabel)
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
}
