//
//  MainListProtocal.swift
//  SuperApp
//
//  Created by Basheer AlHader on 16/12/2022.
//

import Foundation
import UIKit
import SafariServices

protocol MainListRepresentation: ViewDisplayable, MainListRouter {
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

protocol MainListRouter: AnyObject {
    func openSFSafari(with link: URL)
}

extension MainListRouter where Self: UIViewController {

    func openSFSafari(with link: URL) {
        let safariController = SFSafariViewController(url: link)
        safariController.modalPresentationStyle = .overCurrentContext
        present(safariController, animated: true)
    }
}

