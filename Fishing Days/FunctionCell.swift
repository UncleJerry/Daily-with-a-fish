//
//  FunctionCell.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/25.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class FunctionCell: UICollectionViewCell {
    
    @IBOutlet weak var FunctionName: UILabel!
    @IBOutlet weak var FunctionIcon: UIImageView!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var FunctionButton: FunctionButton!
    
    // MARK: - public API
    var function: Feature! {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        FunctionName.text = function.name
        FunctionIcon.image = function.icon
        Description.text = function.descrisption
        FunctionButton.command = function.navigation
    }
    
    // MARK: - refactor layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
}
