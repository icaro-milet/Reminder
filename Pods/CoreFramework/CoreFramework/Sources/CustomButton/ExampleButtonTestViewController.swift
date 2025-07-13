//
//  ExampleButtonTestViewController.swift
//  CoreFramework
//
//  Created by milet on 12/07/25.
//

import Foundation
import UIKit

public class ButtonTestViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard let starImage = UIImage(systemName: "star") else {
            return
        }
        
        let buttonWithIcon = CustomButton(title: "com ícone", icon: starImage, iconPosition: .horizontal)
        let buttonWithoutIcon = CustomButton(title: "sem ícone, simples")
        
        buttonWithIcon.translatesAutoresizingMaskIntoConstraints = false
        buttonWithoutIcon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonWithIcon)
        view.addSubview(buttonWithoutIcon)
        
        NSLayoutConstraint.activate([
            buttonWithIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonWithIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonWithIcon.heightAnchor.constraint(equalToConstant: 50),
            buttonWithIcon.widthAnchor.constraint(equalToConstant: 300),
            
            buttonWithoutIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonWithoutIcon.topAnchor.constraint(equalTo: buttonWithIcon.bottomAnchor, constant: 20),
            buttonWithoutIcon.heightAnchor.constraint(equalToConstant: 50),
            buttonWithoutIcon.widthAnchor.constraint(equalToConstant: 200)
            
        ])
        
    }
}
