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
        setUpObserver()
        tapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.navigationBar.isHidden = true
    }

    private func setupConstraints() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(imageVK)
        self.scrollView.addSubview(stackView)
        self.stackView.addArrangedSubview(textFieldStackView)
        self.stackView.addArrangedSubview(logInButton)
        self.textFieldStackView.addArrangedSubview(emailTextField)
        self.textFieldStackView.addArrangedSubview(passwordTextField)

        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let scrollViewLeftConstraint = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        let centerXImageConstraint = self.imageVK.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let bottomImageConstraint = self.imageVK.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -90)
        let widthImageConstraint = self.imageVK.widthAnchor.constraint(equalToConstant: 100)
        let heightImageConstraint = self.imageVK.heightAnchor.constraint(equalToConstant: 100)

        let stackViewCenterYConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let stackViewCenterXConstraint = self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let stackViewLeftConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let stackViewRightConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([scrollViewTopConstraint, scrollViewLeftConstraint, scrollViewRightConstraint, scrollViewBottomConstraint, centerXImageConstraint, bottomImageConstraint, widthImageConstraint, heightImageConstraint, stackViewCenterYConstraint, stackViewCenterXConstraint, stackViewLeftConstraint, stackViewRightConstraint])

        let leadingTextFieldStackConstraint = self.textFieldStackView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor)
        let trailingTextFieldStackConstraint = self.textFieldStackView.rightAnchor.constraint(equalTo: self.stackView.rightAnchor)
        let heightTextFieldStackConstraint = self.textFieldStackView.heightAnchor.constraint(equalToConstant: 100)

        let topButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor)
        let trailingButtonConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor)
        let heightButtonConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([leadingTextFieldStackConstraint, trailingTextFieldStackConstraint, heightTextFieldStackConstraint, topButtonConstraint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint])

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }

    private func setUpObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        removeKeyboardNotifications()
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= getMoveableDistance(keyboarHeight: keyboardFrame.height)
        }
    }

    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    private func getMoveableDistance(keyboarHeight : CGFloat) ->  CGFloat{
        var y: CGFloat = 0.0
        if let activeTF = getSelectedTextField() {
            var tfMaxY = activeTF.frame.maxY
            var containerView = activeTF.superview!
            while containerView.frame.maxY != self.view.frame.maxY {
                let contViewFrm = containerView.convert(activeTF.frame, to: containerView.superview)
                tfMaxY = tfMaxY + contViewFrm.minY
                containerView = containerView.superview!
            }

            let keyboardMinY = self.view.frame.height - keyboarHeight
            if tfMaxY > keyboardMinY {
                y = tfMaxY - keyboardMinY + 16
            }
        }

        return y
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

extension LogInViewController {
    func getSelectedTextField() -> UITextField? {

        let totalTextFields = getTextFieldsInView(view: self.view)

        for textField in totalTextFields {
            if textField.isFirstResponder {
                return textField
            }
        }

        return nil
    }

    func getTextFieldsInView(view: UIView) -> [UITextField] {

        var totalTextFields = [UITextField]()

        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                totalTextFields += [textField]
            } else {
                totalTextFields += getTextFieldsInView(view: subview)
            }
        }

        return totalTextFields
    }
}
