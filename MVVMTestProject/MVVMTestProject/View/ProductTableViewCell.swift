//
//  ProductTableViewCell.swift
//  MVVMTestProject
//
//  Created by Arul on 12/19/18.
//  Copyright © 2018 Arul. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var mfgLabel: UILabel!
    @IBOutlet weak var productNamelabel: UILabel!
    @IBOutlet weak var productIdlabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!

    let controller = ViewController()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //MARK: Internal Methods for Cell UI configure
    func configure(with product: Product) {
        self.mfgLabel.text = product.mfgDate;
        self.productNamelabel.text = product.productName;
        self.productPriceLabel.text = product.price.amount.rate;
        self.productIdlabel.text = product.pID;
    }
    
    //MARK: Internal Methods for Cell Selection UI configure

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
