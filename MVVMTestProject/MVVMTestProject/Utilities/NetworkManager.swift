//
//  NetworkManager.swift
//  MVVMTestProject
//
//  Created by Arul on 12/19/18.
//  Copyright © 2018 Arul. All rights reserved.
//

import Foundation

class NetworkingHandler {
    static func fetchData(at urlString: String, handler: ((Any?, Error?)->())?)  {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data, let productList = try? JSONDecoder().decode(Products.self, from: data) {
                    handler?(productList, nil)
                }
                else {
                    handler?(nil, error)
                }
                }.resume()
        }
        else {
            handler?(nil, nil)
        }
    }
}
