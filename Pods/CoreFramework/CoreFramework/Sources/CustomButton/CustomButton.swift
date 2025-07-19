//
//  CustomButton.swift
//  CoreFramework
//
//  Created by milet on 12/07/25.
//

import Foundation
import UIKit

public protocol CustomButtonDelegate: AnyObject {
    func buttonAction()
}

public class CustomButton: UIButton {
    public weak var delegate: CustomButtonDelegate?
    
    private var iconPosition: NSLayoutConstraint.Axis?
    private var customWidth: CGFloat?
    
    public init(title: String, backgroundColor: UIColor = Colors.primaryRedBase) {
        super.init(frame: .zero)
        setupButton(title: title, icon: nil, iconPosition: nil, backgroundColor: backgroundColor)
    }
    
    public init(title: String, icon: UIImage, iconPosition: NSLayoutConstraint.Axis ,backgroundColor: UIColor = Colors.primaryRedBase) {
        super.init(frame: .zero)
        setupButton(title: title, icon: icon, iconPosition: iconPosition, backgroundColor: backgroundColor)
    }
    
    public init(title: String, width: CGFloat ,backgroundColor: UIColor = Colors.primaryRedBase) {
        super.init(frame: .zero)
        setupButton(title: title, icon: nil, iconPosition: nil, backgroundColor: backgroundColor)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String,
                             icon:UIImage?,
                             iconPosition: NSLayoutConstraint.Axis?,
                             backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = Typography.subHeading
        self.setTitleColor(Colors.gray800, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = Metrics.medium
        self.isEnabled = true
        
        if let icon = icon, let iconPosition = iconPosition {
            self.setImage(icon, for: .normal)
            self.tintColor = Colors.gray100
            self.iconPosition = iconPosition
            
            adjustIconPosition()
        }
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped() {
        delegate?.buttonAction()
        print("botão clicado")
    }
    
    private func adjustIconPosition() {
        guard let iconPosition = iconPosition else { return }
        
        if iconPosition == .horizontal {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        } else {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0)
        }
    }
}
