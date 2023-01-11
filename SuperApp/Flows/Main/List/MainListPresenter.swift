//
//  MainPresenter.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import Foundation

final class MainListPresenter {

    // MARK: - Properties
    private var jobsList = [Job]()
    private var searchList = [String]()
    private var isSearchActive = false
    private var isPositionSearchActive = false
    private var position: String?
    private var location: String?
    private var selectedProvider: JobsProvider!
    private weak var view: MainListRepresentation!
    private var useCase: ProvidersUseCase!

    // MARK: - Init / Deinit
    init(with view: MainListRepresentation, useCase: ProvidersUseCase) {
        self.view = view
        self.useCase = useCase

        setup()
    }
    
    // MARK: - Private
    private func setup() {
        selectedProvider = JobsProvider.allCases.first
    }
    private func handleAvailableJobsResult(_ result: (jobs: [Job]?, error: Error?)) {
        if let jobs = result.jobs {
            jobsList = jobs
            if jobsList.isEmpty {
                view.showAlert(with: Constant.noResult)
            }
        } else if let error = result.error {
            view.showAlert(with: error.localizedDescription)
        }
        view.updateList()
    }
    private func searchFilter(with list: [String], by text: String?) -> [String] {
        list.filter({ $0.range(of: text ?? "", options: .caseInsensitive) != nil })
    }
}

extension MainListPresenter: MainListDelegate {
    
    var positionSearchActivated: Bool {
        isPositionSearchActive
    }
    var selectedProviderTitle: String {
        selectedProvider.rawValue
    }
    var jobProviderCount: Int {
        JobsProvider.allCases.count
    }
    func getProviderItem(at row: Int) -> String {
        JobsProvider.allCases[row].rawValue
    }
    var searchActivated: Bool {
        isSearchActive
    }
    func getJobItem(at row: Int) -> Job {
        jobsList[row]
    }
    func getSearchItem(at row: Int) -> String {
        searchList[row]
    }
    func getJobLink(at row: Int) -> URL? {
        URL(string: jobsList[row].jobLink ?? "")
    }
    func updateSelectedProvider(at row: Int) {
        selectedProvider = JobsProvider.allCases[row]
    }
    var mainListCount: Int {
        if isSearchActive, !searchList.isEmpty {
            return searchList.count
        }
        return jobsList.count
    }
    func getAvailableJobs() {

        view.showLoading()
        useCase.getJobs(from: selectedProvider,
                        position: position ?? "",
                        location: location ?? "") { [weak self] (jobsList, error) in
            guard let self = self else { return }
            self.view.hideLoading()
            self.handleAvailableJobsResult((jobs: jobsList, error: error))
        }
    }
    func updateProvider() {
        jobsList.removeAll()
        view.updateList()
        getAvailableJobs()
    }
    func updateFilterValues(_ position: String?, location: String?) {
        self.position = position?.replacingOccurrences(of: " ", with: "+")
        self.location = location?.replacingOccurrences(of: " ", with: "+")
        searchClear()
        getAvailableJobs()
    }
    func searchPosition(by text: String?) {
        isSearchActive = true
        isPositionSearchActive = true
        searchList = searchFilter(with: useCase.allPostions, by: text)
    }
    func searchlocation(by text: String?) {
        isSearchActive = true
        isPositionSearchActive = false
        searchList = searchFilter(with: useCase.allLocations, by: text)
    }
    func searchClear() {
        isSearchActive = false
        searchList.removeAll()
        view.updateList()
    }
    
    func openSFSafari(at row: Int) {
        if let url = getJobLink(at: row) {
            view.openSFSafari(with: url)
        }
    }
}
