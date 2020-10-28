//
//  GFAlertContainerView.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/28/20.
//

import UIKit

@IBDesignable class GFAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
