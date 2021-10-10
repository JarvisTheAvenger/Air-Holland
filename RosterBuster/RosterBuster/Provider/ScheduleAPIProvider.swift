//
//  ScheduleProvider.swift
//  ScheduleProvider
//
//  Created by Rahul on 05/10/21.
//

import Foundation

struct ScheduleAPIProvider: ScheduleListProvider {
    
    func getAirlineSchedules(completion: @escaping AirlineScheduleProviderCompletion) {
        APIResource<[Schedule]>(url: APIEndpoints.getFlightSchedule).request { (result) in
            switch result {
            case .success(let response):
                self.save(schedules: response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
