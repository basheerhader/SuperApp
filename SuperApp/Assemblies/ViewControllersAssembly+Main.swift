//
//  ViewControllersAssembly+Main.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit

extension ViewControllersAssembly {
  
    static func makeMainViewController() -> UIViewController {
        let viewController: MainListViewController = main.makeViewController()
        let presenter = MainListPresenter(with: viewController, useCase: ProvidersUseCase(), router: viewController)
        viewController.presenter = presenter
        return viewController.navigation
    }
}
