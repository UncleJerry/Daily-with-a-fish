//
//  ButtonView.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/26.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class ButtonView: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - refactor layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 6.0
        self.clipsToBounds = true
    }

}
