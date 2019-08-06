//
//  AlarmController.swift
//  myAlarm
//
//  Created by Michael Moore on 8/5/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {

    func scheduleUserNotifications(for alarm: Alarm)

    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm){
        let content = UNMutableNotificationContent()
            content.title = "Title"
            content.body = "Body"
            content.sound = UNNotificationSound.default()
        
        var date = DateComponents()
        date.hour = Calendar.current.component(.hour, from: alarm.fireDate)
        date.minute = Calendar.current.component(.minute, from: alarm.fireDate)
        date.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("NOTIFICATION FAILED")
                print(error.localizedDescription)
                print(error)
            }
        }
        print("got scheduled")
    }
    
    
    func cancelUserNotifications(for alarm: Alarm) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        print("got cancelled")
    }
}
    


class AlarmController: AlarmScheduler {
    
    static let shared = AlarmController()
    
    init() {
        loadFromPersistentStorage()
    }
    
    var alarms: [Alarm] = []

    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        
        scheduleUserNotifications(for: newAlarm)
        saveToPersistentStorage()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        
        cancelUserNotifications(for: alarm)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled.toggle()
        
        if alarm.enabled == true {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }

        
        saveToPersistentStorage()
    }

    // MARK: - Persistence
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "alarm.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }

    func saveToPersistentStorage() {

        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileURL())
        } catch let encodingError {
            print("There was an error saving! \(encodingError.localizedDescription)")
        }
    }

    func loadFromPersistentStorage() {

        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedEntries = try jsonDecoder.decode([Alarm].self, from: data)
            self.alarms = decodedEntries
        } catch let decodingError {
            print("There was an error decoding! \(decodingError.localizedDescription)")
        }
    }

} // End of class

