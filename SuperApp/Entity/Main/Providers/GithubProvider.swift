//
//  GithubProvider.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import Foundation

struct GithubProvider: Codable {
    let id, type: String?
    let url: String?
    let createdAt, company: String?
    let companyURL: String?
    let location, title, description, howToApply: String?
    let companyLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type, url
        case createdAt = "created_at"
        case company
        case companyURL = "company_url"
        case location, title, description
        case howToApply = "how_to_apply"
        case companyLogo = "company_logo"
    }
}
