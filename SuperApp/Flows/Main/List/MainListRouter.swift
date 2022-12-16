//
//  MainListRouter.swift
//  SuperApp
//
//  Created by Basheer AlHader on 17/12/2022.
//

import Foundation
import UIKit
import SafariServices

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
