//
//  GFButton.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/26/20.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero) // we'll use autolayout instead of explicit frame
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    

    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline) // bold
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
