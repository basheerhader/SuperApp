//
//  ViewControllersAssembly+Main.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit
import SwiftUI

extension ViewControllersAssembly {
  
    static func makeMainViewController() -> UIViewController {
//        return makeMainViewControllerSwiftUI()
        let viewController: MainListViewController = main.makeViewController()
        let useCase: ProvidersUseCase = APIProvidersUseCase()
        let presenter = MainListPresenter(with: viewController, useCase: useCase)
        viewController.presenter = presenter
        return viewController.navigation
    }
    
    
//    static func makeMainViewControllerSwiftUI() -> UIViewController {
//
//        var mainListSwiftUIView = MainListSwiftUIView()
//        let presenter = MainListPresenter(with: mainListSwiftUIView, useCase: ProvidersUseCase())
//        mainListSwiftUIView.presenter = presenter
//        return UIHostingController(rootView: mainListSwiftUIView)
//    }
}
