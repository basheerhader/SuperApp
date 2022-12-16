//
//  ProvidersUseCase.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import Foundation

enum JobsProviders: String, CaseIterable {
    case github = "Github"
    case searchGOV = "Search.gov"
}

typealias jobsCompletion = ([Job]?, Error?)->Void

final class ProvidersUseCase {
    
    func getJobs(from proviver: JobsProviders,
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
    
    private func callJobProvider(_ proviver: JobsProviders, link: String, completion: @escaping jobsCompletion) {
//
//        Alamofire.request(link).validate().responseJSON { [weak self] response in
//            guard let self = self else { return }
//
//            switch response.result {
//            case .success:
//                
//                if let responseValue = response.result.value,
//                    let responseData = try? JSONSerialization.data(withJSONObject: responseValue) {
//                    self.mapJobProviderResult(proviver, data: responseData, completion: completion)
//                } else {
//                    fatalError("\(proviver.rawValue) returned success but without valid data")
//                }
//
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }
    }
    
    private func mapJobProviderResult(_ proviver: JobsProviders, data: Data, completion: @escaping jobsCompletion) {
        
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
