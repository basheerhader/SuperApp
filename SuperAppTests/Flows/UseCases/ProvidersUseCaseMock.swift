//
//  ProvidersUseCaseMock.swift
//  SuperAppTests
//
//  Created by Basheer AlHader on 15/01/2023.
//

import Foundation
@testable import SuperApp


class ProvidersNetworkMockSuccess: ProvidersNetwork {
    
    func request(proviver: JobsProvider, position: String, location: String, completion: @escaping (Data?, Error?) -> Void) {
        // retuern Success data
        completion(Data(), nil)
    }
    
    func mapJobProviderResult(_ proviver: JobsProvider, data: Data, completion: @escaping jobsCompletion) {
        // retuern Success data
        
        let jobsList: [Job] = [
            Job(id: "1", companyLogo: "logo", jobTitle: "python", jobLink: "google.com", companyName: "Google", location: "Alabama", postdate: nil),
            Job(id: "2", companyLogo: "logo2", jobTitle: "nursing", jobLink: "apple.com", companyName: "Apple", location: "Alaska", postdate: nil)
        ]
        
        completion(jobsList, nil)
    }
    
}


class ProvidersNetworkMockFailure: ProvidersNetwork {
    
    func request(proviver: JobsProvider, position: String, location: String, completion: @escaping (Data?, Error?) -> Void) {
        // retuern Failure data
        let error = NSError(domain: "", code: 500, userInfo:[NSLocalizedDescriptionKey: "Server Error"])
        completion(nil, error)
    }
    
    func mapJobProviderResult(_ proviver: JobsProvider, data: Data, completion: @escaping jobsCompletion) {
        // retuern Failure data
        let error = NSError(domain: "", code: 500, userInfo:[NSLocalizedDescriptionKey: "Server Error"])

        completion(nil, error)
    }
    
}


class ProvidersDataBaseMockSuccess: ProvidersDataBase {
    
    func getListFromPlist(fileName: PlistName) -> [String] {
        
        switch fileName {
        case .positions:
            return ["iOS Developer"]
        case.locations:
            return ["New York"]
        }
    }
    
}


class ProvidersDataBaseMockFailure: ProvidersDataBase {
    
    func getListFromPlist(fileName: PlistName) -> [String] {
        []
    }
}
