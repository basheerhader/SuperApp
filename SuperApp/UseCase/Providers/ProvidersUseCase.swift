//
//  ProvidersUseCase.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import Foundation

enum JobsProvider: String, CaseIterable {
    case github = "Github"
    case searchGOV = "Search.gov"
}

enum PlistName: String {
    case locations = "Locations"
    case positions = "Positions"
}

typealias jobsCompletion = ([Job]?, Error?)->Void

protocol ProvidersUseCase: AnyObject {
    var allLocations: [String] { get }
    var allPostions: [String] { get }
    func getJobs(from proviver: JobsProvider,
                 position: String,
                 location: String,
                 completion: @escaping jobsCompletion)
}

final class APIProvidersUseCase: ProvidersUseCase {
    
    private let network: ProvidersNetwork!
    private let dataBase: ProvidersDataBase!

    init(_ network: ProvidersNetwork = APIProvidersNetwork(),
         dataBase: ProvidersDataBase = APIProvidersDataBase()) {
        self.network = network
        self.dataBase = dataBase
    }
    
    // MARK: Public
    var allLocations: [String] {
        dataBase.getListFromPlist(fileName: PlistName.locations)
    }
    
    var allPostions: [String] {
        dataBase.getListFromPlist(fileName: PlistName.positions)
    }

    func getJobs(from proviver: JobsProvider,
                 position: String,
                 location: String,
                 completion: @escaping jobsCompletion) {
        
        network.request(proviver: proviver,
                        position: position,
                        location: location) { [weak self] date, error in
            guard let self = self else { return }
            if let date = date {
                self.network.mapJobProviderResult(proviver, data: date, completion: completion)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }

}
