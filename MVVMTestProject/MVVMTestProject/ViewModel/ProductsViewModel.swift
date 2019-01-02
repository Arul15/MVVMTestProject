//
//  ProductsViewModel.swift
//  MVVMTestProject
//
//  Created by Arul on 12/19/18.
//  Copyright © 2018 Arul. All rights reserved.
//

import Foundation

class ProductsViewModel {
    var productsList: Products?
    let limit = 2
    
    func loadproductsList(at urlString: String, handler: ((Error?)->())?)   {
        NetworkingHandler.fetchData(at: urlString) {[weak self] (response, error) in
            self?.productsList = response as? Products
            handler?(error)
        }
    }
}

// MARK: - Methods for tableView's dataSource
extension ProductsViewModel {
    var todosTitle: String {
        return "Number of Products: \(self.numberOfProducts)"
    }
    
    var numberOfProducts: Int {
        return self.productsList?.count ?? 0
    }
    
    func product(at index: Int) -> Product? {
        return self.productsList?[index]
    }
    
    func compareSameProduct(at selectedRows: Array<IndexPath>) -> Bool {
        return self.productsList?[selectedRows[0].row] == self.productsList?[selectedRows[1].row]
    }
    
    func showCompareButton(countofSelectedRows selectedRows: Array<Any>) -> Bool {
        if selectedRows.count == limit {
            return true
        }
        return false
    }
}
