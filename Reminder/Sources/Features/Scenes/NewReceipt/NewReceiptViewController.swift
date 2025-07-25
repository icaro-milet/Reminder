//
//  NewReceiptViewController.swift
//  Reminder
//
//  Created by milet on 27/06/25.
//

import Foundation
import UIKit
import Lottie
import CoreFramework

class NewReceiptViewController: UIViewController {
    private let newReceiptView = NewReceiptView()
    private let viewModel = NewReceiptViewModel()
    
    
    private let successAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true
        
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        presentOnboarding()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.gray800
        view.addSubview(newReceiptView)
        view.addSubview(successAnimationView)
        
        self.navigationItem.hidesBackButton = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        newReceiptView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newReceiptView.topAnchor.constraint(equalTo: view.topAnchor),
            newReceiptView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newReceiptView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newReceiptView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            successAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250),
            successAnimationView.heightAnchor.constraint(equalToConstant: 60),
            successAnimationView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupActions() {
        newReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        newReceiptView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addButtonTapped() {
        let remedy = newReceiptView.remedyInput.getText()
        let time = newReceiptView.timeInput.getText()
        let recurrence = newReceiptView.recurrenceInput.getText()
        let takeNow = false
        
        viewModel.addReceipt(remedy: remedy,
                             time: time,
                             recurrence: recurrence,
                             takeNow: takeNow)
        
        playSuccessAnimation()
        print("receita \(remedy) adicionado(a)")
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func clearFieldsAndResetButton() {
        newReceiptView.remedyInput.textField.text = ""
        newReceiptView.timeInput.textField.text = ""
        newReceiptView.recurrenceInput.textField.text = ""
        
        newReceiptView.addButton.isEnabled = false
        newReceiptView.addButton.backgroundColor = newReceiptView.addButton.isEnabled ? Colors.primaryRedBase : Colors.gray500
    }
    
    private func playSuccessAnimation() {
        successAnimationView.isHidden = false
        successAnimationView.play { [weak self] finished in
            if finished {
                self?.successAnimationView.isHidden = true
                self?.clearFieldsAndResetButton()
            }
        }
    }
    
    private func presentOnboarding() {
        if !UserDefaultsManager.hasSeenOnboarding() {
            let onboardingView = OnboardingView()
            let steps = [
                (UIImage(named: "welcome-onboarding"), "Bem-vindo ao onboarding do Reminder"),
                (UIImage(named: "image2"), "Simples para cadastrar remédios"),
            ]
            
            onboardingView.presentOnboarding(on: view, with: steps)
            UserDefaultsManager.markOnboardingSeen()
        }
    }
}
