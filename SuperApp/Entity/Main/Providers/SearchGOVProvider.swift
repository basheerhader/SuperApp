//
//  SearchGOVProvider.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import Foundation

struct SearchGOVProvider: Codable {
    let id, positionTitle, organizationName, rateIntervalCode: String?
    let minimum, maximum: Int?
    let startDate, endDate: String?
    let locations: [String]?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case positionTitle = "position_title"
        case organizationName = "organization_name"
        case rateIntervalCode = "rate_interval_code"
        case minimum, maximum
        case startDate = "start_date"
        case endDate = "end_date"
        case locations, url
    }
}
