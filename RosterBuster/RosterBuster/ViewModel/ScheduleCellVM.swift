//
//  ScheduleCellVM.swift
//  ScheduleCellVM
//
//  Created by Rahul on 10/10/21.
//

import Foundation
import UIKit

class ScheduleCellVM {
    private let schedule: Schedule
    
    var captain: String { return schedule.captain }
    var firstOfficer: String { return schedule.firstOfficer }
    var flightAttendant: String { return schedule.flightAttendant }
    
    var dutyType: String { return schedule.dutyCode.rawValue }
    
    var date: String { return schedule.date.convertDateToReadableFormat() }
    
    var aircraftType: String { return "\(schedule.aircraftType) "}
    
    var place: String { return "\(schedule.departure) - \(schedule.destination)" }
    var flightTiming: String { return "\(schedule.departTime) - \(schedule.arrivalTime)" }
    
    var isflightTimeHidden: Bool { return schedule.dutyCode == .off }
    var isMatchCrewHidden: Bool { return !(schedule.dutyCode == .standby) }
    
    var source: String { return schedule.departure }
    var destination: String { return schedule.destination }
    
    var flightImage: String {
        switch schedule.dutyCode {
        case .layover:
            return "layover"
        case .standby:
            return "standby"
        case .off:
            return "airplane_off"
        default:
            return "airplane"
        }
    }
    
    init(_ schedule: Schedule) {
        self.schedule = schedule
    }
}
