//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by milet on 10/06/25.
//

import Foundation
import UIKit

class LoginBottomSheetViewController: UIViewController {
    
    var mainNavigation: UINavigationController?
    let loginView = LoginBottomSheetView()
    let loginViewModel = LoginBottomSheetViewModel()
    var handleAreaHeight: CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        setupUI()
        setupGesture()
        bindViewModel()
    }
    
    private func setupUI() {
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let heightConstraint = loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
            .isActive = true
    }
    
    private func bindViewModel() {
        loginViewModel.successResult = { [weak self] in
            let viewController = UIViewController()
            viewController.view.backgroundColor = .cyan
            
            self?.dismiss(animated: false)
            self?.mainNavigation?.pushViewController(viewController, animated: true)
        }
    }
    
    private func setupGesture() {
        
    }
    
    private func handlePanGesture() {
        
    }
    
    func animateShow(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        loginView.transform = CGAffineTransform(translationX: 0, y: loginView.frame.height)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loginView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(username: String, password: String) {
        loginViewModel.doAuth(usernameLogin: username, password: password)
    }
    
}
