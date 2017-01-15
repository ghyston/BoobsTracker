//
//  RecordViewController.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 15/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import UIKit

class RecordViewController : UIViewController
{
    @IBOutlet weak var lastTimeLabel: UILabel!
    
    @IBAction func leftBtnClick(_ sender: Any)
    {
        print("left")
        //@todo
    }
    
    @IBAction func rightBtnClick(_ sender: Any)
    {
        print("right")
        //@todo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
