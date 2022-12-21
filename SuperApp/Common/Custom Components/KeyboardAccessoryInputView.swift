//
//  KeyboardAccessoryInputView.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit

final class KeyboardAccessoryInputView: UIToolbar, NibLoadable {

    @IBOutlet private weak var leftBarButton: UIButton!
    
    // MARK: Properties
    
    var onClickOnDoneButton: (()->Void)?
    
    // MARK: Actions

    @IBAction private func doneButtonTapped(_ sender: Any) {
        onClickOnDoneButton?()
    }
    
}
