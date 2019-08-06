//
//  AlarmListTableViewController.swift
//  myAlarm
//
//  Created by Michael Moore on 8/5/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else {return UITableViewCell()}
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell.alarm = alarm
        cell.delegate = self
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // identify
        if segue.identifier == "AlarmDetailTableViewController" {
            // index
            if let indexPath = tableView.indexPathForSelectedRow {
                // destination
                guard let destinationVC = segue.destination as? AlarmDetailTableViewController else {return}
                // object to be sent
                let alarm = AlarmController.shared.alarms[indexPath.row]
                // object to landing pad
                destinationVC.alarm = alarm
            
            }
        }
    }
}


extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let alarm = cell.alarm,
            let indexPath = tableView.indexPath(for: cell) else {return}
        AlarmController.shared.toggleEnabled(for: alarm)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    
}
