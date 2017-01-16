//
//  RoundButton.swift
//  BoobsTracker
//
//  Created by Ilja Stepanow on 16/01/2017.
//  Copyright © 2017 Ilja Stepanow. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        
        self.layoutIfNeeded()
        layer.cornerRadius = self.frame.height / 2.0
        layer.masksToBounds = true
        
    }

}
