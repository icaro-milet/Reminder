//
//  HomeView.swift
//  Reminder
//
//  Created by milet on 24/06/25.
//

import UIKit
import CoreFramework

class HomeView: UIView {
    weak public var delegate: HomeViewDelegate?
    
    let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Metrics.medium
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray800
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = Metrics.medium
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "home.welcome.label".localized
        label.textColor = Colors.gray200
        label.font = Typography.input
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = Colors.gray100
        textField.font = Typography.heading
        textField.returnKeyType = .done
        textField.placeholder = "Insira seu nome"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let myPrescriptionsButton: ButtonHomeView = {
        let button = ButtonHomeView(icon: UIImage(named: "Paper"),
                                    title: "Minhas receitas",
                                    description: "Acompanhe os medicamentos e gerencie lembretes")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let newPrescriptionButton: ButtonHomeView = {
        let button = ButtonHomeView(icon: UIImage(named: "Pills"),
                                    title: "Nova receita",
                                    description: "Cadastre novos lembretes")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let feedbackButton: CustomButton = {
        let starImage = UIImage(named: "star") ?? UIImage()
        let button = CustomButton(title: "home.feedback.button.title".localized,
                                  icon: starImage,
                                  iconPosition: .horizontal,
                                  backgroundColor: Colors.gray100)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
// -------------------------- COMO ERA ANTES ----------------------------------
//    let feedbackButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("home.feedback.button.title".localized, for: .normal)
//        button.backgroundColor = Colors.gray100
//        button.layer.cornerRadius = Metrics.medium
//        button.setTitleColor(.white, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        return button
//    }()
// -----------------------------------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTextField()
        self.backgroundColor = Colors.gray600
        feedbackButton.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(profileBackground)
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(nameTextField)
        
        addSubview(contentBackground)
        contentBackground.addSubview(feedbackButton)
        contentBackground.addSubview(myPrescriptionsButton)
        contentBackground.addSubview(newPrescriptionButton)
        
        setupConstraints()
        setupImageGesture()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: topAnchor),
            profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileBackground.heightAnchor.constraint(equalToConstant: Metrics.backgroundProfileSize),
            
            profileImage.topAnchor.constraint(equalTo: profileBackground.topAnchor, constant: Metrics.huge),
            profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.medium),
            profileImage.heightAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            profileImage.widthAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.small),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.tiny),
            nameTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            
            contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            feedbackButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -Metrics.medium),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
            
            myPrescriptionsButton.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.huge),
            myPrescriptionsButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            myPrescriptionsButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
            myPrescriptionsButton.heightAnchor.constraint(equalToConstant: 112),
            
            newPrescriptionButton.topAnchor.constraint(equalTo: myPrescriptionsButton.bottomAnchor, constant: Metrics.medium),
            newPrescriptionButton.leadingAnchor.constraint(equalTo: myPrescriptionsButton.leadingAnchor),
            newPrescriptionButton.trailingAnchor.constraint(equalTo: myPrescriptionsButton.trailingAnchor),
            newPrescriptionButton.heightAnchor.constraint(equalTo: myPrescriptionsButton.heightAnchor)
        ])
    }
    
    private func setupImageGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(profileImageTapped))
        
        profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func profileImageTapped() {
        delegate?.didTapProfileImage()
    }
    
    private func setupTextField() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidEndEditing), for: .editingDidEnd)
        nameTextField.delegate = self
    }
    
    @objc
    private func nameTextFieldDidEndEditing() {
        let userName = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(name: userName)
    }
}


extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let userName = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(name: userName)
        
        return true
    }
}

extension HomeView: CustomButtonDelegate {
    func buttonAction() {
        if let url = URL(string: "http://www.google.com/"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
            
    }
}
