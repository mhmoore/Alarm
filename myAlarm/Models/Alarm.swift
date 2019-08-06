//
//  Alarm.swift
//  myAlarm
//
//  Created by Michael Moore on 8/5/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.fireDate == rhs.fireDate &&
            lhs.enabled == rhs.enabled
    }
    
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    let uuid: String
    
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: fireDate)
    }
    
    init(fireDate: Date, name: String, enabled: Bool) {
        
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = UUID().uuidString
    }
    
    
}
