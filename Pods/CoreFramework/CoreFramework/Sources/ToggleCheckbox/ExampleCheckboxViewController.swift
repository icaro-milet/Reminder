//
//  ExampleCheckbox.swift
//  CoreFramework
//
//  Created by milet on 12/07/25.
//

import Foundation
import UIKit

public class ExampleCheckboxViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let checkbox = ToggleCheckbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkbox)
        
        NSLayoutConstraint.activate([
            checkbox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkbox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 60),
            checkbox.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
