//
//  ViewController.swift
//  MVVMTestProject
//
//  Created by Arul on 12/19/18.
//  Copyright © 2018 Arul. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var compareButton: UIButton!
    
    let viewModel = ProductsViewModel()
    let cellIdentifier = "TableViewCell"
    
    //MARK: Private Properties
    private enum Constants {
        static let apiURL = "https://api.myjson.com/bins/9asku"
        
    }
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge, color: .gray,  placeInTheCenterOf: view)
        activityIndicator.startAnimating()
        
        self.viewModel.loadproductsList(at: Constants.apiURL) {[weak self] (error) in
            DispatchQueue.main.async {
                if error == nil {
                    self?.tableView.reloadData()
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    //MARK: IBAction Methods Methods
    @IBAction func compareAction(sender: UIButton)  {
        if let sr = self.tableView.indexPathsForSelectedRows {
            if self.viewModel.compareSameProduct(at: sr) {
                presentAlert(withTitle: "Error", message: "You are not allowed to compare same product")
            } else {
                presentAlert(withTitle: "Success", message: "You can able to compare different products")
            }
        }
    }
}

// MARK: - UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ProductTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProductTableViewCell
        if let productItem = self.viewModel.product(at: indexPath.row) {
            cell.configure(with: productItem)
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate Methods
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let sr = tableView.indexPathsForSelectedRows {
            if self.viewModel.showCompareButton(countofSelectedRows: sr) {
                presentAlert(withTitle: "Error", message: "You are limited to \(self.viewModel.limit) selections")
                return nil
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.compareButton.isHidden = !self.viewModel.showCompareButton(countofSelectedRows: tableView.indexPathsForSelectedRows ?? Array())
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.compareButton.isHidden = !self.viewModel.showCompareButton(countofSelectedRows: tableView.indexPathsForSelectedRows ?? Array())
    }
}

// MARK: - Activity Indicator
extension UIActivityIndicatorView {
    
    convenience init(activityIndicatorStyle: UIActivityIndicatorViewStyle, color: UIColor, placeInTheCenterOf parentView: UIView) {
        self.init(activityIndicatorStyle: activityIndicatorStyle)
        center = parentView.center
        self.color = color
        parentView.addSubview(self)
    }
}

// MARK: - UIAlert Controller
extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
