//
//  MainListProtocal.swift
//  SuperApp
//
//  Created by Basheer AlHader on 16/12/2022.
//

import Foundation

protocol MainListRepresentation: ViewDisplayable {
    func updateList()
}

protocol MainListDelegate: AnyObject {
    
    var searchActivated: Bool { get }
    var positionSearchActivated: Bool { get }
    var mainListCount: Int { get }
    var jobProviderCount: Int { get }
    var selectedProviderTitle: String { get }

    func getProviderItem(at row: Int) -> String
    func getJobItem(at row: Int) -> Job
    func getSearchItem(at row: Int) -> String
    func getJobLink(at row: Int) -> URL?
    func getAvailableJobs()
    func updateProvider()
    func updateFilterValues(_ position: String?, location: String?)
    func searchPosition(by text: String?)
    func searchlocation(by text: String?)
    func searchClear()
    func updateSelectedProvider(at row: Int)
    func openSFSafari(at row: Int)
}
