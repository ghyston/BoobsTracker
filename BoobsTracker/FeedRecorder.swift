//
//  FeedRecorder.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 18/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import Foundation
import UIKit

protocol FeedRecorder {
    func updateLabel(lastFeed: FeedRecord?, label: UILabel!)
    func stringFromTimeInterval(_ interval: TimeInterval) -> String
}

extension FeedRecorder
{
    func updateLabel(lastFeed: FeedRecord?, label: UILabel!)
    {
        if lastFeed == nil
        {
            label.text = "No record data yet"
            return
        }
        
        let diff : TimeInterval = NSDate ().timeIntervalSince(lastFeed!.feedTime as! Date)
        
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
        
        let part4 = lastFeed!.isLeft ?
            NSMutableAttributedString(string: "L", attributes: leftAttributes) :
            NSMutableAttributedString(string: "R", attributes: rightAttributes)
        
        let combination = NSMutableAttributedString()
        
        combination.append(part1)
        combination.append(part2)
        combination.append(part3)
        combination.append(part4)
        
        label.attributedText = combination
        
    }
    
    func stringFromTimeInterval(_ interval: TimeInterval) -> String
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
}
