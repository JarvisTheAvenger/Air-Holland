//
//  Schedule.swift
//  Schedule
//
//  Created by Rahul on 05/10/21.
//

import Foundation

enum DutyType: String, Codable {
    case standby = "Standby"
    case flight = "FLIGHT"
    case layover = "LAYOVER"
    case off = "OFF"
    case positioning = "POSITIONING"
}

struct Schedule: Codable {
    let flightner: String
    let date: String
    let aircraftType: String
    let tail: String
    let departure: String
    let destination: String
    let departTime: String
    let arrivalTime: String
    let dutyID: String
    let dutyCode: DutyType
    let captain: String
    let firstOfficer: String
    let flightAttendant: String
    
    enum CodingKeys: String, CodingKey {
        case flightner = "Flightnr"
        case date = "Date"
        case aircraftType = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case departTime = "Time_Depart"
        case arrivalTime = "Time_Arrive"
        case dutyID = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case firstOfficer = "First Officer"
        case flightAttendant = "Flight Attendant"
    }
    
}
