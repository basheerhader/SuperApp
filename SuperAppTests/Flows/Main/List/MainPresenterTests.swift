//
//  MainPresenterTests.swift
//  JobFinderTests
//
//  Created by OSX on 4/20/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import XCTest
@testable import SuperApp

class MainPresenterTests: XCTestCase {

    var view = MainListMock()
    var useCaseSuccess = ProvidersUseCaseMockSuccess()
    var useCaseFailure = ProvidersUseCaseMockFailure()
    var useCaseJobsEmpty = ProvidersUseCaseMockJobsEmpty()
    var presenter: MainListRecipient!
    
    override func setUp() {
        presenter = MainListPresenter(with: view, useCase: useCaseSuccess)
        presenter.getAvailableJobs()
    }

    func testGetProviderItemSuccess() {
        // Given
        var providerIndexRow = 0
        // When
        var item = presenter.getProviderItem(at: providerIndexRow)
        // Then
        XCTAssertTrue(item == "Github")
        // Given
        providerIndexRow = 1
        // When
        item = presenter.getProviderItem(at: providerIndexRow)
        // Then
        XCTAssertTrue(item == "Search.gov")
    }

    func testGetProviderItemFailure() {
        // Given
        var providerIndexRow = 0
        // When
        var item = presenter.getProviderItem(at: providerIndexRow)
        // Then
        XCTAssertFalse(item == "Search.gov")
        // Given
        providerIndexRow = 1
        // When
        item = presenter.getProviderItem(at: providerIndexRow)
        // Then
        XCTAssertFalse(item == "Github")
    }
    
    func testGetJobItemSuccess() {
        
        // Given
        var jobItemIndexRow = 0
        // When
        var item = presenter.getJobItem(at: jobItemIndexRow)
        // Then
        XCTAssertTrue(item.id == "1")
        // Given
        jobItemIndexRow = 1
        // When
        item = presenter.getJobItem(at: jobItemIndexRow)
        // Then
        XCTAssertTrue(item.id == "2")
    }

    func testGetJobItemFailure() {
        // Given
        var jobItemIndexRow = 0
        // When
        var item = presenter.getJobItem(at: jobItemIndexRow)
        // Then
        XCTAssertFalse(item.id == "2")
        // Given
        jobItemIndexRow = 1
        // When
        item = presenter.getJobItem(at: jobItemIndexRow)
        // Then
        XCTAssertFalse(item.id == "1")
    }
    
    func testGetSearchPositionItemSuccess() {
        // Given
        var indexRow = 0
        presenter.searchPosition(by: "python")
        // When
        var item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertTrue(item == "python")
        // Given
        indexRow = 0
        presenter.searchPosition(by: "iOS Developer")
        // When
        item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertTrue(item == "iOS Developer")
    }

    func testGetSearchPositionItemFailure() {
        // Given
        var indexRow = 0
        presenter.searchPosition(by: "python")
        // When
        var item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertFalse(item == "iOS Developer")
        // Given
        indexRow = 0
        presenter.searchPosition(by: "iOS Developer")
        // When
        item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertFalse(item == "python")
    }
    
    func testGetSearchlocationItemSuccess() {
        // Given
        var indexRow = 0
        presenter.searchlocation(by: "Alabama")
        // When
        var item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertTrue(item == "Alabama")
        // Given
        indexRow = 0
        presenter.searchlocation(by: "Alaska")
        // When
        item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertTrue(item == "Alaska")
    }

    func testGetSearchlocationItemFailure() {
        // Given
        var indexRow = 0
        presenter.searchlocation(by: "Alabama")
        // When
        var item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertFalse(item == "Alaska")
        // Given
        indexRow = 0
        presenter.searchlocation(by: "Alaska")
        // When
        item = presenter.getSearchItem(at: indexRow)
        // Then
        XCTAssertFalse(item == "Alabama")
    }
    
    func testGetJobLinkSuccess() {
        // Given
        var indexRow = 0
        // When
        var item = presenter.getJobLink(at: indexRow)
        // Then
        XCTAssertTrue(item?.absoluteString == "google.com")
        // Given
        indexRow = 1
        // When
        item = presenter.getJobLink(at: indexRow)
        // Then
        XCTAssertTrue(item?.absoluteString == "apple.com")
    }

    func testGetJobLinkFailure() {
        // Given
        var indexRow = 0
        // When
        var item = presenter.getJobLink(at: indexRow)
        // Then
        XCTAssertFalse(item?.absoluteString == "apple.com")
        // Given
        indexRow = 1
        // When
        item = presenter.getJobLink(at: indexRow)
        // Then
        XCTAssertFalse(item?.absoluteString == "google.com")
    }
    
    func testUpdateProviderSuccess() {
        // When
        presenter.updateProvider()
        // Then
        XCTAssertTrue(presenter.mainListCount == 2)
    }
    
    func testUpdateProviderFailure() {
        // When
        presenter.updateProvider()
        // Then
        XCTAssertFalse(presenter.mainListCount == 0)
    }
    

    func testUpdateFilterValuesSuccess() {
        // Given
        let posistion = "python"
        let location = "Alabama"
        let indexRow = 0
        // When
        presenter.updateFilterValues(posistion, location: location)
        // Then
        XCTAssertTrue(presenter.getJobItem(at: indexRow).location == "Alabama")
    }
    
    func testUpdateFilterValuesFailure() {
        // Given
        let posistion = "python"
        let location = "Alabama"
        let indexRow = 0
        // When
        presenter.updateFilterValues(posistion, location: location)
        // Then
        XCTAssertFalse(presenter.getJobItem(at: indexRow).location == "Jordan")
    }
    
    
    func testSearchClearSuccess() {
        // When
        presenter.searchClear()
        // Then
        XCTAssertTrue(presenter.mainListCount == 2)
    }
    
    func testSearchClearFailure() {
        // When
        presenter.searchClear()
        // Then
        XCTAssertFalse(presenter.mainListCount != 2)
    }
    
    func testUpdateSelectedProviderSuccess() {
        // Given
        var indexRow = 0
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertTrue(presenter.getProviderItem(at: indexRow) == "Github")
        // Given
        indexRow = 1
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertTrue(presenter.getProviderItem(at: indexRow) == "Search.gov")
    }

    func testUpdateSelectedProviderFailure() {
        // Given
        var indexRow = 1
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertFalse(presenter.getProviderItem(at: indexRow) == "Github")
        // Given
        indexRow = 0
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertFalse(presenter.getProviderItem(at: indexRow) == "Search.gov")
    }
    
    func testOpenSFSafariSuccess() {
        // Given
        let indexRow = 0
        // When
        presenter.openSFSafari(at: indexRow)
        // Then
        XCTAssertTrue(view.openSFSafaritCalled)
    }

    func testOpenSFSafariFailure() {
        // Given
        let indexRow = 0
        // When
        presenter.openSFSafari(at: indexRow)
        // Then
        XCTAssertFalse(!view.openSFSafaritCalled)
    }
    
    func testSearchActivatedSuccess() {
        // When
        presenter.searchPosition(by: "iOS")
        // Then
        XCTAssertTrue(presenter.searchActivated)
        XCTAssertTrue(presenter.mainListCount == 1)

        // When
        presenter.searchlocation(by: "Ca")
        // Then
        XCTAssertTrue(presenter.searchActivated)
    }

    func testSearchActivatedFailure() {
        // When
        presenter.searchPosition(by: "iOS")
        // Then
        XCTAssertFalse(!presenter.searchActivated)
        
        // When
        presenter.searchlocation(by: "Ca")
        // Then
        XCTAssertFalse(!presenter.searchActivated)
    }
    
    func testPositionSearchActivatedSuccess() {
        // When
        presenter.searchPosition(by: "iOS")
        // Then
        XCTAssertTrue(presenter.positionSearchActivated)
        
        // When
        presenter.searchlocation(by: "Ca")
        // Then
        XCTAssertTrue(!presenter.positionSearchActivated)
    }

    func testPositionSearchActivatedFailure() {
        // When
        presenter.searchPosition(by: "iOS")
        // Then
        XCTAssertFalse(!presenter.positionSearchActivated)
        
        // When
        presenter.searchlocation(by: "Ca")
        // Then
        XCTAssertFalse(presenter.positionSearchActivated)
    }
    
    func testJobProviderCountSuccess() {
        // Then
        XCTAssertTrue(presenter.jobProviderCount == 2)
    }

    func testJobProviderCountFailure() {
        // Then
        XCTAssertFalse(presenter.jobProviderCount == .zero)
    }
    
    func testSelectedProviderTitleSuccess() {
        // Given
        var indexRow = 0
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertTrue(presenter.selectedProviderTitle == "Github")
        // Given
        indexRow = 1
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertTrue(presenter.selectedProviderTitle == "Search.gov")
    }

    func testSelectedProviderTitleFailure() {
        // Given
        var indexRow = 1
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertFalse(presenter.selectedProviderTitle == "Github")
        // Given
        indexRow = 0
        // When
        presenter.updateSelectedProvider(at: indexRow)
        // Then
        XCTAssertFalse(presenter.selectedProviderTitle == "Search.gov")
    }
    
    func testGetJobFailure() {
        // Given
        presenter = MainListPresenter(with: view, useCase: useCaseFailure)
        // When
        presenter.getAvailableJobs()
        presenter.searchClear()
        // Then
        XCTAssertTrue(presenter.mainListCount == .zero)
        XCTAssertTrue(view.showLoadingCalled)
    }
    
    func testGetJobEmpty() {
        // Given
        presenter = MainListPresenter(with: view, useCase: useCaseJobsEmpty)
        // When
        presenter.getAvailableJobs()
        presenter.searchClear()
        // Then
        XCTAssertTrue(presenter.mainListCount == .zero)
        XCTAssertTrue(view.showLoadingCalled)
    }
    
    func testSearchPositionWhenItNullWithEmptyJobs() {
        // Given
        presenter = MainListPresenter(with: view, useCase: useCaseJobsEmpty)
        // When
        presenter.getAvailableJobs()
        presenter.searchPosition(by: nil)
   
        // Then
        XCTAssertTrue(presenter.mainListCount == .zero)
    }
    
    func testJobLinkWhenItNull() {
        // Given
        useCaseSuccess.jobLinkActive = false
        presenter = MainListPresenter(with: view, useCase: useCaseSuccess)
        let index = 0
        // When
        presenter.getAvailableJobs()
   
        // Then
        XCTAssertTrue(presenter.getJobLink(at: index) == nil)
    }
    
    func testAvailableCount() {
        // Then
        XCTAssertTrue(presenter.mainListCount == 2)
    }
}
