//
//  UIViewController.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import Foundation
import UIKit

extension UIViewController: StoryboardInitiable{}

protocol StoryboardInitiable {
    
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
    static var nibView: UIView { get }
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension NibLoadable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static var nibView: UIView {
        
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Can't instantiate a \(self)")
        }
        
        return view
    }
    
    static func load<T: UIView>() -> T {
        
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? T else {
            fatalError("Can't instantiate a \(self)")
        }
        
        return view
    }
    
    func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Can't instantiate a \(self)")
        }
        
        return view
    }
}

protocol ViewDisplayable: AnyObject {
    func showLoading()
    func hideLoading()
    func showAlert(with message: String)
    func present(to viewCoreoller: UIViewController)

}

extension ViewDisplayable where Self: UIViewController {
    
    func showLoading() {
    }
    
    func hideLoading() {
    }
    
    func present(to viewCoreoller: UIViewController) {
        present(viewCoreoller, animated: true)
    }
    
    func showAlert(with message: String) {
   
    }
}
