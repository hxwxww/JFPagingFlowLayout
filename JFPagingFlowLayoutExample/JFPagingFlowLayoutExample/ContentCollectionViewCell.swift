//
//  ContentCollectionViewCell.swift
//  JFPagingFlowLayoutExample
//
//  Created by HongXiangWen on 2020/4/16.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cyan
        layer.masksToBounds = true
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
}
