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
}

extension MainMock: MainListRepresentation {
    
    func present(to viewCoreoller: UIViewController) {
        
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
