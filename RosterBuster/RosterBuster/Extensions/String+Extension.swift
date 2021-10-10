//
//  String+Extension.swift
//  String+Extension
//
//  Created by Rahul on 10/10/21.
//

import Foundation

extension String {
    func convertDateToReadableFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd MMM yyyy"
        return  dateFormatter.string(from: date!)
    }
}
