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
    
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero) // we'll use autolayout instead of explicit frame
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    

    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline) // bold
        setTitleColor(.systemGray, for: .disabled)
    }
    
}

extension GFButton {
    override var isEnabled: Bool {
        didSet {
            DispatchQueue.main.async {
                if self.isEnabled {
                    self.alpha = 1.0
                }
                else {
                    self.alpha = 0.5
                }
            }
        }
    }
}
