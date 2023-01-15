//
//  ProvidersDataBase.swift
//  SuperApp
//
//  Created by Basheer AlHader on 15/01/2023.
//

import Foundation

protocol ProvidersDataBase: AnyObject {
    func getListFromPlist(fileName: PlistName) -> [String]
}

final class APIProvidersDataBase: ProvidersDataBase {

    func getListFromPlist(fileName: PlistName) -> [String] {

        if let path = Bundle.main.path(forResource: fileName.rawValue, ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }
}
