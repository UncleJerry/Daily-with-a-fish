//
//  GeneralCollectionCell.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/29.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class GeneralCollectionCell: UICollectionViewCell {
    // MARK: - refactor layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
}
