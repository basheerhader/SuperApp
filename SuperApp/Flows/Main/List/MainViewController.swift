//
//  MainViewController.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit
import SafariServices

final class MainViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var providerTextField: UITextField!
    @IBOutlet private weak var positionTextField: UITextField!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Parameters

    var presenter: MainPresenter!
    private lazy var pickerView = UIPickerView()
    private var selectedJobsProvider = JobsProviders.allCases.first
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MainViewCell.self)
        configurePickerView()
        
        presenter.getAvailableJobs()
    }
    
    // MARK: Private

    private func configurePickerView() {

        providerTextField.text = JobsProviders.allCases.first?.rawValue
        providerTextField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let keyboardAccessoryInputView: KeyboardAccessoryInputView = KeyboardAccessoryInputView.load()
        keyboardAccessoryInputView.onClickOnDoneButton = { [weak self] in
            guard let self = self, let selectedJobsProvider = self.selectedJobsProvider else { return }
            self.providerTextField.resignFirstResponder()

            self.presenter.updateProvider(selectedJobsProvider)
            self.presenter.getAvailableJobs()
        }
        
        providerTextField.inputAccessoryView = keyboardAccessoryInputView
    }
    
    // MARK: Actions

    @IBAction private func filterButtonTapped(_ sender: Any) {
        
        presenter.searchClear()
        tableView.reloadData()
        
        presenter.updateFilterValues(positionTextField.text, location: locationTextField.text)
        presenter.getAvailableJobs()
    }
    
    @IBAction private func textFieldDidChanged(_ sender: UITextField) {
        
        if sender == positionTextField {
            presenter.searchPosition(by: sender.text ?? "")
        } else {
            presenter.searchlocation(by: sender.text ?? "")
        }
        tableView.reloadData()
    }
}

// MARK: Table View Methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if presenter.isSearchActive {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = presenter.searchList[indexPath.row]
            return cell
        } else {
            let cell: MainViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(with: presenter.jobsList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if presenter.isSearchActive {

            if presenter.isPositionSearchActive {
                positionTextField.text = presenter.searchList[indexPath.row]
            } else {
                locationTextField.text = presenter.searchList[indexPath.row]
            }
            
            presenter.searchClear()
            tableView.reloadData()
            
        } else if let jobLink = presenter.jobsList[indexPath.row].jobLink,
            let url = URL(string: jobLink) {
            
            let safariController = SFSafariViewController(url: url)
            safariController.modalPresentationStyle = .overCurrentContext
            present(safariController, animated: true)
        }
    }
}

// MARK: - JobSearch Representation

extension MainViewController: MainRepresentation {
    
    func updateList() {
        tableView.reloadData()
    }
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        JobsProviders.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        JobsProviders.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        providerTextField.text = JobsProviders.allCases[row].rawValue
        selectedJobsProvider = JobsProviders.allCases[row]
    }
}

