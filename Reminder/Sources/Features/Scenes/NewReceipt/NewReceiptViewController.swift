//
//  NewReceiptViewController.swift
//  Reminder
//
//  Created by milet on 27/06/25.
//

import Foundation
import UIKit

class NewReceiptViewController: UIViewController {
    private let newReceiptView = NewReceiptView()
    private let viewModel = NewReceiptViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.gray800
        view.addSubview(newReceiptView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        newReceiptView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newReceiptView.topAnchor.constraint(equalTo: view.topAnchor),
            newReceiptView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newReceiptView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newReceiptView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        
        print("receita \(remedy) adicionado(a)")
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
