//
//  ScheduleProvider.swift
//  ScheduleProvider
//
//  Created by Rahul on 10/10/21.
//

import Foundation

typealias AirlineScheduleProviderCompletion = (Result<[Schedule], Error>) -> Void

protocol ScheduleListProvider {
    func getAirlineSchedules(completion: @escaping AirlineScheduleProviderCompletion)
    func save(schedules: [Schedule])
}

extension ScheduleListProvider {
    func save(schedules: [Schedule]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(schedules) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedSchedules")
        }
    }
}
