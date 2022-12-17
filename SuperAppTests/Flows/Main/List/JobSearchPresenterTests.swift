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

    var view = MainMock()
    var presenter: MainListDelegate!
    
    override func setUp() {
        presenter = MainListPresenter(with: view, useCase: ProvidersUseCase())
    }


//    var searchActivated: Bool { get }
//    var positionSearchActivated: Bool { get }
//    var mainListCount: Int { get }
//    var jobProviderCount: Int { get }
//    var selectedProviderTitle: String { get }
    
//    func getProviderItem(at row: Int) -> String
//    func getJobItem(at row: Int) -> Job
//    func getSearchItem(at row: Int) -> String
//    func getJobLink(at row: Int) -> URL?
//    func getAvailableJobs()
//    func updateProvider()
//    func updateFilterValues(_ position: String?, location: String?)
//    func searchPosition(by text: String?)
//    func searchlocation(by text: String?)
//    func searchClear()
//    func updateSelectedProvider(at row: Int)
//    func openSFSafari(at row: Int)
    
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
    
}
