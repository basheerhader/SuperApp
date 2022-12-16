//
//  MainViewCell.swift
//  SuperApp
//
//  Created by Basheer AlHader on 14/12/2022.
//

import UIKit

class MainViewCell: UITableViewCell, NibLoadable {

    // MARK: - BOutlets

    @IBOutlet private weak var companyImageView: UIImageView!
    @IBOutlet private weak var jobTitleLabel: UILabel!
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!

    // MARK: - configuretion
    
    func configure(with object: Job) {
        
        jobTitleLabel.text = object.jobTitle
        companyNameLabel.text = object.companyName
        locationLabel.text = object.location
        postDateLabel.text = object.postdate?.asString
    }
}
