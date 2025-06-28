//
//  ReminderFlowController.swift
//  Reminder
//
//  Created by milet on 13/06/25.
//

import Foundation
import UIKit

class ReminderFlowController: HomeFlowDelegate {
    
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllersFactory: ViewControllersFactoryProtocol
    
    // MARK: - init
    public init() {
        self.viewControllersFactory = ViewControllersFactory()
    }
    
    // MARK: - startFlow
    func start() -> UINavigationController? {
        let startViewController = viewControllersFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
    
    func navigateToRecipes() {
        let recipesViewController = viewControllersFactory.makeNewRecipesViewController()
        self.navigationController?.pushViewController(recipesViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func logout() {
        self.navigationController?.popViewController(animated: true)
        self.openLoginBottomSheet()
    }
}

// MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: true)
        
        let viewController = viewControllersFactory.makeHomeViewController(flowDelegate: self)
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

// MARK: - Splash
extension ReminderFlowController: SplashFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheet = viewControllersFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        
        navigationController?.present(loginBottomSheet, animated: false){
            loginBottomSheet.animateShow()
        }
        
        func navigateToHome() {
            self.navigationController?.dismiss(animated: true)
            
            let viewController = UIViewController()
            viewController.view.backgroundColor = .cyan
            
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}
