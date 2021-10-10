//
//  ScheduleViewModel.swift
//  ScheduleViewModel
//
//  Created by Rahul on 10/10/21.
//

import Foundation

class ScheduleVM {
    typealias scheduleCompletion = (Result<[[String: [ScheduleCellVM]]], Error>)->Void
    
    private var provider: ScheduleListProvider
    private(set) var schedules = [[String: [ScheduleCellVM]]]()
    
    init(_ provider: ScheduleListProvider) {
        self.provider = provider
    }
    
    func getSchedules(completion: @escaping scheduleCompletion) {
        if !Reachability.isConnectedToNetwork() {
            provider = ScheduleOfflineProvider()
        }
        
        provider.getAirlineSchedules { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let schedules):
                `self`.refineFlightSchedules(schedules, completion: completion)
                                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func refineFlightSchedules(_ schedules: [Schedule],
                                       completion: scheduleCompletion) {
        let dictionary = Dictionary(grouping: schedules, by: { $0.date })
        
        // Create raw datasource with key as a date string and value as a array of cell viewmodels
        let rawResult = dictionary.map { dateString, _schedules -> [String: [ScheduleCellVM]] in
            var cellVMs = [ScheduleCellVM]()
            for el in _schedules { cellVMs.append(ScheduleCellVM(el)) }
            return [dateString.convertDateToReadableFormat() : cellVMs]
        }
        
        // Sort the result based on the date
        let result = rawResult.sorted { x1, x2 in
            x1.keys.first! < x2.keys.first!
        }
        
        self.schedules = result
        completion(.success(result))
    }
    
}
