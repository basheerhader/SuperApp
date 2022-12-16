//
//  ViewControllersAssembly+Main.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit

extension ViewControllersAssembly {
  
    static func makeMainViewController() -> UIViewController {
        let viewController: MainViewController = main.makeViewController()
        let presenter = MainPresenter(with: viewController, useCase: ProvidersUseCase())
        viewController.presenter = presenter
        return viewController.navigation
    }
}
