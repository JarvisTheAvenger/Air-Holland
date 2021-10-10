//
//  ScheduleOfflineProvider.swift
//  ScheduleOfflineProvider
//
//  Created by Rahul on 10/10/21.
//

import Foundation

enum OfflineProviderError: Error {
    case decodingFailed
}

struct ScheduleOfflineProvider: ScheduleListProvider {
    func getAirlineSchedules(completion: @escaping AirlineScheduleProviderCompletion) {
        let defaults = UserDefaults.standard
        
        if let savedSchedules = defaults.object(forKey: "SavedSchedules") as? Data {
            let decoder = JSONDecoder()
            if let schedules = try? decoder.decode([Schedule].self, from: savedSchedules) {
                completion(.success(schedules))
            } else {
                completion(.failure(OfflineProviderError.decodingFailed))
            }
        } else {
            completion(.success([]))
        }
    }
    
}
