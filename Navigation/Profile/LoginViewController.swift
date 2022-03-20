//
//  LoginViewController.swift
//  Navigation
//
//  Created by elena on 20.03.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var imageVK: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "logoVK")
        imageView.image = image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray6
        stackView.spacing = 0
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.tintColor = .lightGray
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.placeholder = "Email of phone"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.autocapitalizationType = .none
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.tintColor = .lightGray
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
     //   button.backgroundColor = UIColor(named: "color")
        button.backgroundColor = UIColor.white.withAlphaComponent(0.8) // в функции tapLogInButton() есть другой метод через if else, но этот метод лучше, не подтормаживает
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapLogInButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.navigationBar.isHidden = true
    }

    private func setupConstraints() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(imageVK)
        self.stackView.addArrangedSubview(textFieldStackView)
        self.stackView.addArrangedSubview(logInButton)
        self.textFieldStackView.addArrangedSubview(emailTextField)
        self.textFieldStackView.addArrangedSubview(passwordTextField)

        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let scrollViewLeftConstraint = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)


        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor)
        let contentViewLeftConstraint = self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor)
        let contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)


        let stackViewTopConstraint = self.stackView.topAnchor.constraint(equalTo: self.imageVK.bottomAnchor, constant: 120)
        let stackViewLeftConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let stackViewRightConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let stackViewBottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -300)

        NSLayoutConstraint.activate([scrollViewTopConstraint, scrollViewBottomConstraint, scrollViewRightConstraint, scrollViewLeftConstraint, contentViewTopConstraint, contentViewCenterXConstraint, contentViewRightConstraint, contentViewLeftConstraint, contentViewBottomConstraint, stackViewTopConstraint, stackViewLeftConstraint, stackViewRightConstraint, stackViewBottomConstraint])

        let topImageConstraint = self.imageVK.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120)
        let centerXImageConstraint = self.imageVK.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        let widthImageConstraint = self.imageVK.widthAnchor.constraint(equalToConstant: 100)
        let heightImageConstraint = self.imageVK.heightAnchor.constraint(equalToConstant: 100)

        let topTextFieldStackConstraint = self.textFieldStackView.topAnchor.constraint(equalTo: self.stackView.topAnchor)
        let leadingTextFieldStackConstraint = self.textFieldStackView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor)
        let trailingTextFieldStackConstraint = self.textFieldStackView.rightAnchor.constraint(equalTo: self.stackView.rightAnchor)
        let heightSTextFieldStackConstraint = self.textFieldStackView.heightAnchor.constraint(equalToConstant: 100)

        let topButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor)
        let trailingButtonConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor)
        let heightButtonConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([topImageConstraint, centerXImageConstraint, widthImageConstraint, heightImageConstraint, topTextFieldStackConstraint, leadingTextFieldStackConstraint, trailingTextFieldStackConstraint, heightSTextFieldStackConstraint, topButtonConstraint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint])

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func tapLogInButton() {

//        if logInButton.isSelected {
//            logInButton.alpha = 0.8
//        } else if logInButton.isHighlighted {
//            logInButton.alpha = 0.8
//        } else if logInButton.isEnabled {
//            logInButton.alpha = 0.8
//        } else {
//            logInButton.alpha = 1
//        }
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
        print("Log")
    }
}

