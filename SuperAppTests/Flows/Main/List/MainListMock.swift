//
//  MainMock.swift
//  JobFinderTests
//
//  Created by OSX on 4/20/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import Foundation
import UIKit
@testable import SuperApp

class MainListMock {
    var updateListCalled = false
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var displayAlertCalled = false
    var presentCalled = false
    var openSFSafaritCalled = false
}

extension MainListMock: MainListPresentation {
    
    func openSFSafari(with link: URL) {
        openSFSafaritCalled = true
    }
    func present(to viewCoreoller: UIViewController) {
        presentCalled = true
    }
    func updateList() {
        updateListCalled = true
    }
    func showLoading() {
        showLoadingCalled = true
    }
    func showAlert(with message: String) {
        displayAlertCalled = true
    }
    func hideLoading() {
        hideLoadingCalled = true
    }
    
}

class ProvidersUseCaseMockSuccess: ProvidersUseCase {
    var jobLinkActive = true
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
        let jobsList: [Job] = [
            Job(id: "1", companyLogo: "logo", jobTitle: "python", jobLink: jobLinkActive ? "google.com" : nil, companyName: "Google", location: "Alabama", postdate: nil),
            Job(id: "2", companyLogo: "logo2", jobTitle: "nursing", jobLink: jobLinkActive ? "apple.com" : nil, companyName: "Apple", location: "Alaska", postdate: nil)
        ]
        completion(jobsList, nil)
    }
    
    private func getListFromPlist(fileName: String) -> [String] {

        if let path = Bundle.main.path(forResource: fileName, ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }
}

class ProvidersUseCaseMockFailure: ProvidersUseCase {
    
    var allLocations: [String] { [] }
    var allPostions: [String] { [] }
    func getJobs(from proviver: JobsProvider,
                 position: String,
                 location: String,
                 completion: @escaping jobsCompletion) {
        
        let error = NSError(domain: "", code: 500, userInfo:[NSLocalizedDescriptionKey: "Server Error"])
        completion(nil, error)
    }
}

class ProvidersUseCaseMockJobsEmpty: ProvidersUseCase {
    
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
        completion([], nil)
    }
    private func getListFromPlist(fileName: String) -> [String] {

        if let path = Bundle.main.path(forResource: fileName, ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }
}
