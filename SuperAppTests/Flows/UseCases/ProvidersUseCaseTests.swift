//
//  ProvidersUseCaseTests.swift
//  SuperAppTests
//
//  Created by Basheer AlHader on 15/01/2023.
//

import XCTest
@testable import SuperApp

class ProvidersUseCaseTests: XCTestCase {

    var networkSuccess = ProvidersNetworkMockSuccess()
    var networkFailure = ProvidersNetworkMockFailure()

    var dataBaseSuccess = ProvidersDataBaseMockSuccess()
    var dataBaseFailure = ProvidersDataBaseMockFailure()
    
    var useCase: APIProvidersUseCase!

    override func setUp() {
        useCase = APIProvidersUseCase(networkSuccess, dataBase: dataBaseSuccess)
    }
    
    func testGetJobsGithubItemsSuccess() {
        // Given
        let position = "iOS Developer"
        let location = "New York"

        // When
        useCase.getJobs(from: .github, position: position, location: location) { jobs, error in
            // Then
            XCTAssertTrue(jobs != nil)
        }
    }
    
    func testGetJobsSearchGOVItemsSuccess() {
        // Given
        let position = "iOS Developer"
        let location = "New York"

        // When
        useCase.getJobs(from: .searchGOV, position: position, location: location) { jobs, error in
            // Then
            XCTAssertTrue(jobs != nil)
        }
    }
    
    
    
    func testGetallLocationsSuccess() {

        // Then
        XCTAssertTrue(useCase.allLocations.isEmpty == false)
    }
    
    func testGetallPostionsSuccess() {

        // Then
        XCTAssertTrue(useCase.allPostions.isEmpty == false)
    }

    
    func testGetJobsItemsFailure() {
        // Given
        useCase = APIProvidersUseCase(networkFailure, dataBase: dataBaseFailure)
        let position = "iOS Developer"
        let location = "New York"

        // When
        useCase.getJobs(from: .github, position: position, location: location) { jobs, error in
            // Then
            XCTAssertTrue(jobs == nil)
        }
    }
    
    func testGetallLocationsFailure() {
        // Given
        useCase = APIProvidersUseCase(networkFailure, dataBase: dataBaseFailure)
        // Then
        XCTAssertTrue(useCase.allLocations.isEmpty == true)
    }
    
    func testGetallPostionsFailure() {
        // Given
        useCase = APIProvidersUseCase(networkFailure, dataBase: dataBaseFailure)
        // Then
        XCTAssertTrue(useCase.allPostions.isEmpty == true)
    }
    
}
