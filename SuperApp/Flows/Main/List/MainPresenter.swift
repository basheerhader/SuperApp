//
//  MainPresenter.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit

protocol MainRepresentation: ViewDisplayable {
    func updateList()
}

final class MainPresenter {

    // MARK: - Properties
    
    private(set) var jobsList = [Job]()
    private(set) var searchList = [String]()
    private(set) var isSearchActive = false
    private(set) var isPositionSearchActive = false
    private(set) var jobsProviders = JobsProviders.allCases.first
    private(set) var position: String?
    private(set) var location: String?
    
    private weak var view: MainRepresentation!
    private var useCase: ProvidersUseCase!

    // MARK: - Init / Deinit
    
    init(with view: MainRepresentation, useCase: ProvidersUseCase) {
        
        self.view = view
        self.useCase = useCase
    }
    
    // MARK: - Table view methods

    func getNumberOfRowsInSection() -> Int {
        
        if isSearchActive, !searchList.isEmpty {
            return searchList.count
        } else {
            isSearchActive = false
            return jobsList.count
        }
    }
    
    // MARK: - Fetching Data

    func getAvailableJobs() {
        
        guard let jobsProviders = jobsProviders else {
            fatalError("there's no providers")
        }
        
        view.showLoading()
        
        useCase.getJobs(from: jobsProviders, position: position ?? "", location: location ?? "") { [weak self] (jobsList, error)  in
            
            guard let self = self else { return }
            self.view.hideLoading()

            if let jobsList = jobsList {
                self.jobsList = jobsList
                if jobsList.isEmpty {
                    self.view.showAlert(with: "No result")
                }
            } else if let error = error {
                self.view.showAlert(with: error.localizedDescription)
            }
            self.view.updateList()
        }
    }
    
    // MARK: - Update filter fields

    func updateProvider(_ providers: JobsProviders) {
        jobsProviders = providers
        jobsList.removeAll()
        view.updateList()
    }
    
    func updateFilterValues(_ position: String?, location: String?) {
        self.position = position?.replacingOccurrences(of: " ", with: "+")
        self.location = location?.replacingOccurrences(of: " ", with: "+")
    }
    
    // MARK: - Search postions and locations

    func searchPosition(by text: String) {
        isSearchActive = true
        isPositionSearchActive = true
        searchList = getAllPostions().filter({ $0.range(of: text, options: .caseInsensitive) != nil })
    }
    
    func searchlocation(by text: String) {
        isSearchActive = true
        isPositionSearchActive = false
        searchList = getAllLocations().filter({ $0.range(of: text, options: .caseInsensitive) != nil })
    }
    
    func searchClear() {
        isSearchActive = false
        searchList.removeAll()
    }
    
    private func getAllLocations() -> [String] {
        
        if let path = Bundle.main.path(forResource: "Locations", ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }
    
    private func getAllPostions() -> [String] {
        
        if let path = Bundle.main.path(forResource: "Positions", ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }
}
