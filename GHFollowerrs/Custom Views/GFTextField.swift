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
    
    
    fileprivate func configureUserIcon() {
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftView?.backgroundColor = .systemGreen
        
        let userIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        userIcon.image = UIImage(systemName: "person.fill")
        userIcon.translatesAutoresizingMaskIntoConstraints = false
        leftView?.addSubview(userIcon)
        
        NSLayoutConstraint.activate([
            userIcon.centerXAnchor.constraint(equalTo: leftView!.centerXAnchor),
            userIcon.centerYAnchor.constraint(equalTo: leftView!.centerYAnchor)
        ])
    }
    
    private func configure() {
        clipsToBounds = true
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
        
        configureUserIcon()

        placeholder = "Enter a username"
        
    }

        
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 40, height: bounds.height)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds).offsetBy(dx: 8.0, dy: 0.0)
    }


    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds).offsetBy(dx: 8.0, dy: 0.0)
    }
    
}
