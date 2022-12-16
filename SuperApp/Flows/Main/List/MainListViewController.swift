//
//  MainListViewController.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit

final class MainListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var providerTextField: UITextField!
    @IBOutlet private weak var positionTextField: UITextField!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Parameters
    private lazy var pickerView = UIPickerView()
    var presenter: MainListDelegate!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MainViewCell.self)
        configurePickerView()
    }
    
    // MARK: Private
    private func configurePickerView() {
        providerTextField.text = presenter.selectedProviderTitle
        providerTextField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let keyboardAccessoryInputView: KeyboardAccessoryInputView = KeyboardAccessoryInputView.load()
        keyboardAccessoryInputView.onClickOnDoneButton = updateProvider
        providerTextField.inputAccessoryView = keyboardAccessoryInputView
    }
    private func updateProvider() {
        providerTextField.resignFirstResponder()
        presenter.updateProvider()
    }
    
    // MARK: Actions
    @IBAction private func filterButtonTapped(_ sender: Any) {
        presenter.updateFilterValues(positionTextField.text, location: locationTextField.text)
    }
    @IBAction private func textFieldDidChanged(_ sender: UITextField) {
        if sender == positionTextField {
            presenter.searchPosition(by: sender.text)
        } else {
            presenter.searchlocation(by: sender.text)
        }
        tableView.reloadData()
    }
}

// MARK: Table View Methods
extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.mainListCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter.searchActivated {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = presenter.getSearchItem(at: indexPath.row)
            return cell
        } else {
            let cell: MainViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(with: presenter.getJobItem(at: indexPath.row))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if presenter.searchActivated {
            let item = presenter.getSearchItem(at: indexPath.row)
            if presenter.positionSearchActivated {
                positionTextField.text = item
            } else {
                locationTextField.text = item
            }
            presenter.searchClear()
        } else {
            presenter.openSFSafari(at: indexPath.row)
        }
    }
}

extension MainListViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.jobProviderCount
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter.getProviderItem(at: row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        providerTextField.text = presenter.getProviderItem(at: row)
        presenter.updateSelectedProvider(at: row)
    }
}

// MARK: - Main List Representation
extension MainListViewController: MainListRepresentation {
    func updateList() {
        tableView.reloadData()
    }
}

extension MainListViewController: MainListRouter { }
