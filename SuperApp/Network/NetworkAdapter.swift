//
//  NetworkAdapter.swift
//  SuperApp
//
//  Created by Basheer AlHader on 16/12/2022.
//

import Foundation

class NetworkAdapter {
    
    static func request(url: URL, completion: ((Data?, Error?) -> ())? ) {
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            completion?(data, error)
        }
    }
}
