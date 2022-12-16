//
//  Extension.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import Foundation
import UIKit

extension Date {

    var asString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    func date(by dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: self) else {
            fatalError("\(self) can't be converted to \(dateFormat) format")
        }
        return date
    }
}


extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

}


extension UIViewController {

    var navigation: UINavigationController {
        let navigation = UINavigationController(rootViewController: self)
        navigation.modalPresentationStyle = .fullScreen
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.backgroundColor = .white
        return navigation
    }
}


