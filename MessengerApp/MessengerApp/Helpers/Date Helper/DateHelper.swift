//
//  DateHelper.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 07.03.2022.
//

import Foundation

struct DateHelper {
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        return formatter
    }()
    
}
