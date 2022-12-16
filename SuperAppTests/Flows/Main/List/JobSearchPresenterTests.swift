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
    var presenter: MainPresenter!
    
    override func setUp() {
        presenter = MainPresenter(with: view, useCase: ProvidersUseCase())
    }


    func testFilterParams() {

        // When
        presenter.updateProvider(.github)
        presenter.updateFilterValues("", location: "")
        
        // Then
        XCTAssertTrue(presenter.jobsProviders! == .github)
        XCTAssertTrue(presenter.position?.isEmpty == true)
        XCTAssertTrue(presenter.location?.isEmpty == true)

        // When
        presenter.updateFilterValues("ios developer", location: "new york")
        
        // Then
        XCTAssertTrue(presenter.position == "ios+developer")
        XCTAssertTrue(presenter.location == "new+york")
        
        // When
        presenter.updateFilterValues("ios developer 543%%%%%%*", location: "newyork")
        
        // Then
        XCTAssertTrue(presenter.position == "ios+developer+543%%%%%%*")
        XCTAssertTrue(presenter.location == "newyork")
        
        // When
        presenter.updateProvider(.searchGOV)
        presenter.updateFilterValues("", location: "")
        
        // Then
        XCTAssertTrue(presenter.jobsProviders! == .searchGOV)
        XCTAssertTrue(presenter.position?.isEmpty == true)
        XCTAssertTrue(presenter.location?.isEmpty == true)
  
    }
    
    func testSearch() {
        
        // Given
        let expectedSearchResult = ["iOS Developer"]

        // When
        presenter.searchPosition(by: "ios")
        
        // Then
        XCTAssertTrue(presenter.isSearchActive)
        XCTAssertTrue(presenter.isPositionSearchActive)
        XCTAssertEqual(expectedSearchResult, presenter.searchList)

        // Given
        let expectedlocationResult = ["New York"]
        
        // When
        presenter.searchlocation(by: "new")
        
        // Then
        XCTAssertTrue(presenter.isSearchActive)
        XCTAssertFalse(presenter.isPositionSearchActive)
        XCTAssertEqual(expectedlocationResult, presenter.searchList)

        // When
        presenter.searchClear()
        
        // Then
        XCTAssertFalse(presenter.isSearchActive)
        XCTAssertTrue(presenter.searchList.isEmpty)
        
    }

    
    func testNumberOfRowsInSection()  {
 
        // When
        presenter.searchPosition(by: "ios")

        // Then
        XCTAssertTrue(presenter.getNumberOfRowsInSection() > 0)
        XCTAssertFalse(presenter.searchList.isEmpty)

        
    }
    
}
