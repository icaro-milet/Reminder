//
//  SplashView.swift
//  Reminder
//
//  Created by milet on 08/06/25.
//

import Foundation
import UIKit

class SplashView: UIView {
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = Colors.primaryRedBase
        
        self.addSubview(logoImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: Metrics.medium)
        ])
        
    }
}
