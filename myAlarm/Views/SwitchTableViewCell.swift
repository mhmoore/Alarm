//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by Michael Moore on 8/5/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }
}
