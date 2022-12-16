//
//  ViewController.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//


import UIKit

final class ViewControllersAssembly {
    
    // MARK: - Static properties
    
    static private(set) var main: UIStoryboard = { UIStoryboard(name: "Main") }()
    // Add a new storyboard here
    
}

extension UIStoryboard {
    
    // MARK: - Init / Deinit
    
    convenience init(name: String) {
        self.init(name: name, bundle: .main)
    }
    
    // MARK: - Actions
    
    func makeViewController<T: StoryboardInitiable>() -> T {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
    }
}
