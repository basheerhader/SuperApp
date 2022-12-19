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

class MainMock {
    var updateListCalled = false
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var displayAlertCalled = false
    var presentCalled = false
    var openSFSafaritCalled = false
}

extension MainMock: MainListRepresentation {
    
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


class ProvidersUseCaseMock: ProvidersUseCase {

    

    override func getJobs(from proviver: JobsProvider,
                 position: String,
                 location: String,
                 completion: @escaping jobsCompletion) {
        
        
        let jobsList: [Job] = [
            Job(id: "1", companyLogo: "logo", jobTitle: "iOS Developer", jobLink: "google.com", companyName: "Apple", location: "USA", postdate: nil),
            Job(id: "2", companyLogo: "logo2", jobTitle: "iOS Developer2", jobLink: "google2.com", companyName: "Apple2", location: "USA2", postdate: nil)
        ]
        
        completion(jobsList, nil)

        
    }
}


