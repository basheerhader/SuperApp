//
//  ProvidersNetwork.swift
//  SuperApp
//
//  Created by Basheer AlHader on 15/01/2023.
//

import Foundation

protocol ProvidersNetwork: AnyObject {
    func request(proviver: JobsProvider, position: String, location: String, completion: @escaping (Data?, Error?)->Void)
    func mapJobProviderResult(_ proviver: JobsProvider, data: Data, completion: @escaping jobsCompletion)
}

final class APIProvidersNetwork: ProvidersNetwork {
    
    func request(proviver: JobsProvider, position: String, location: String, completion: @escaping (Data?, Error?)->Void) {
        
        var link: String!
        
        switch proviver {
        case .github:
            link = "https://jobs.github.com/positions.json?description=\(position)&location=\(location)"
        case .searchGOV:
            link = "https://jobs.search.gov/jobs/search.json?query=\(position)+jobs+in+\(location)"
        }
        
        guard let url = URL(string: link) else {
            return
        }
        
        NetworkAdapter.request(url: url) { date, error in
            completion(date, error)
        }
    }
    
    func mapJobProviderResult(_ proviver: JobsProvider, data: Data, completion: @escaping jobsCompletion) {
        
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
