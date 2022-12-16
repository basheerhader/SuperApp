//
//  KeyboardAccessoryInputView.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit

final class KeyboardAccessoryInputView: UIView, NibLoadable {

    @IBOutlet weak var leftBarButton: UIButton!
    
    // MARK: Properties
    
    var onClickOnDoneButton: (()->())?
    
    // MARK: Actions

    @IBAction private func doneButtonTapped(_ sender: Any) {
        onClickOnDoneButton?()
    }
    
}
