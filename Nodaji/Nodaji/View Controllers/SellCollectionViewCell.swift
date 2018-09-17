//
//  SellCollectionViewCell.swift
//  Nodaji
//
//  Created by 김영도 on 15/09/2018.
//  Copyright © 2018 Nodaji. All rights reserved.
//

import UIKit

class SellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    
    var imageName: String! {
        didSet {
            productImageView.image = UIImage(named: imageName)
        }
    }
}
