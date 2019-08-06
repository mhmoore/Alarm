//
//  AlarmDetailTableViewController.swift
//  myAlarm
//
//  Created by Michael Moore on 8/5/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    @IBOutlet weak var timeAndDatePicker: UIDatePicker!
    @IBOutlet weak var nameAlarmLabel: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }    
    
    var alarmIsOn: Bool = true
    
    private func updateViews() {
        if let alarm = alarm {
            timeAndDatePicker.date = alarm.fireDate
            nameAlarmLabel.text = alarm.name
            alarmIsOn = alarm.enabled
        }
        
        if alarmIsOn {
            enableButton.setTitle("On", for: .normal)
            enableButton.backgroundColor = .green
        } else {
            enableButton.setTitle("Off", for: .normal)
            enableButton.backgroundColor = .lightGray
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let newTime = timeAndDatePicker.date
        guard let newName = nameAlarmLabel.text else {return}
        
        if let newAlarm = alarm {
           AlarmController.shared.update(alarm: newAlarm, fireDate: newTime, name: newName, enabled: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: newTime, name: newName, enabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn.toggle()
        if alarmIsOn {
            enableButton.setTitle("On", for: .normal)
            enableButton.backgroundColor = .green
        } else {
            enableButton.setTitle("Off", for: .normal)
            enableButton.backgroundColor = .lightGray
        }
        // navigationController?.popViewController(animated: true)
    }
    
}
