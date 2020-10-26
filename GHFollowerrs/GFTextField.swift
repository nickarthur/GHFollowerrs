//
//  GFTextField.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/26/20.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label // supports light and darkmode
        tintColor = .label // blinking cursor color
        font = UIFont.preferredFont(forTextStyle: .title2) // larger text
        adjustsFontSizeToFitWidth = true // adjust font to fit textfield
        minimumFontSize = 12 // don't shrink too much
        
        backgroundColor = .tertiarySystemBackground // don't blend into background
        autocorrectionType = .no  // don't autocorrect
        
        placeholder = "Enter a username"
    }
    
}
