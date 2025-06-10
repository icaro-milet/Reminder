//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by milet on 10/06/25.
//

import Foundation
import UIKit

class LoginBottomSheetViewController: UIViewController {
    
    let loginView = LoginBottomSheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.view.addSubview(loginView)
    }
}
