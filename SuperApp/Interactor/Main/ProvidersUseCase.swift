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

typealias jobsCompletion = ([Job]?, Error?)->Void

final class ProvidersUseCase {
    
        
    // MARK: Public
    var allLocations: [String] {
        getListFromPlist(fileName: "Locations")
    }
    
    var allPostions: [String] {
        getListFromPlist(fileName: "Positions")
    }

    func getJobs(from proviver: JobsProvider,
                 position: String,
                 location: String,
                 completion: @escaping jobsCompletion) {
        
        var providerLink: String!
        
        switch proviver {
        case .github:
            providerLink = "https://jobs.github.com/positions.json?description=\(position)&location=\(location)"
        case .searchGOV:
            providerLink = "https://jobs.search.gov/jobs/search.json?query=\(position)+jobs+in+\(location)"
        }
        
        callJobProvider(proviver, link: providerLink, completion: completion)
    }
    
    // MARK: Private
    private func getListFromPlist(fileName: String) -> [String] {

        if let path = Bundle.main.path(forResource: fileName, ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }

    private func callJobProvider(_ proviver: JobsProvider, link: String, completion: @escaping jobsCompletion) {

        guard let url = URL(string: link) else {
            return
        }
        
        NetworkAdapter.request(url: url) { [weak self] date, error in
            guard let self = self else { return }
            if let date = date {
                self.mapJobProviderResult(proviver, data: date, completion: completion)
                
            } else if let error = error {
                completion(nil, error)
            }
        }
       
    }
    
    private func mapJobProviderResult(_ proviver: JobsProvider, data: Data, completion: @escaping jobsCompletion) {
        
        switch proviver {
        case .github:
            mapGithubProviderResult(for: data, completion: completion)
        case .searchGOV:
            mapSearchGOVProviderResult(for: data, completion: completion)
        }
    }
    
    private func mapGithubProviderResult(for data: Data, completion: @escaping jobsCompletion) {

        do {
            let githubData = try JSONDecoder().decode([GithubProvider].self, from: data)
            
            let jobList = githubData.map( { Job(id: $0.id,
                                                companyLogo: $0.companyLogo,
                                                jobTitle: $0.title,
                                                jobLink: $0.url,
                                                companyName: $0.company,
                                                location: $0.location,
                                                postdate: $0.createdAt?.date(by: "EEE MMM dd HH:mm:ss Z yyyy") ) })
            
            completion(jobList, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    private func mapSearchGOVProviderResult(for data: Data, completion: @escaping jobsCompletion) {

        do {
            let searchGOVData = try JSONDecoder().decode([SearchGOVProvider].self, from: data)
            
            let jobList = searchGOVData.map( { Job(id: $0.id,
                                                   companyLogo: nil,
                                                   jobTitle: $0.positionTitle,
                                                   jobLink: $0.url,
                                                   companyName: $0.organizationName,
                                                   location: $0.locations?.first,
                                                   postdate: $0.startDate?.date(by: "yyyy-mm-dd") ) } )
            
            completion(jobList, nil)
        } catch {
            completion(nil, error)
        }
    }
    

}
