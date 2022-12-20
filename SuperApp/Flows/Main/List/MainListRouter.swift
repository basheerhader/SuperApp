//
//  MainListRouter.swift
//  SuperApp
//
//  Created by Basheer AlHader on 26/05/1444 AH.
//

import Foundation
import UIKit

protocol MainListRouter: AnyObject {
    func openSFSafari(with link: URL)
}

extension MainListRouter where Self: UIViewController {
    func openSFSafari(with link: URL) {
        present(ViewControllersAssembly.makeSFSafariViewController(with: link), animated: true)
    }
}
