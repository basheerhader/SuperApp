//
//  HomeViewController.swift
//  SuperApp
//
//  Created by Basheer AlHader on 01/01/2023.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Actions

    @IBAction private func startButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(ViewControllersAssembly.makeMainViewController(), animated: true)
    }
    
}
