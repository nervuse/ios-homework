//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by elena on 02.03.2022.
//

import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView, UITextFieldDelegate {

    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "котик")
        imageView.image = image
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 69.0
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sullen cat"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Be ready!"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .gray
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.textColor = .black
        return textField
    }()

    private lazy var showStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        return stackView
    }()

    private var statusText = "Be ready!"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(self.avatar)
        self.addSubview(self.statusTextField)
        self.addSubview(self.showStatusButton)
        self.addSubview(labelsStackView)
        self.labelsStackView.addArrangedSubview(self.nameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)

        let labelStackLeadingConstraint = self.labelsStackView.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 16)
        let labelSrackTrailingConstraint = self.labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        let topLabelConstraint = self.labelsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let avatarTopConstraint = self.avatar.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        let avatarLeadingConstraint = self.avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let avatarHeightConstraint = self.avatar.heightAnchor.constraint(equalToConstant: 138)
        let avatarWidthConstraint = self.avatar.widthAnchor.constraint(equalToConstant: 138)
        let topStatusTextConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.labelsStackView.bottomAnchor, constant: 5)
        let leadingStatusTextConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.labelsStackView.leadingAnchor)
        let trailingStatusTextConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.labelsStackView.trailingAnchor)
        let heightStatusTextConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        let buttonTopConstraint = self.showStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let bottomButtonConstraint = self.showStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.showStatusButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([labelStackLeadingConstraint, labelSrackTrailingConstraint, topLabelConstraint, avatarTopConstraint, avatarLeadingConstraint, avatarWidthConstraint, avatarHeightConstraint, topStatusTextConstraint, leadingStatusTextConstraint, trailingStatusTextConstraint, heightStatusTextConstraint, buttonTopConstraint, leadingButtonConstraint, trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint])
        statusTextField.delegate = self
    }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc private func buttonPressed() {
        if let status = self.statusLabel.text {
            print("\(status)")
        }
        guard statusTextField.text != "" else {
            statusTextField.shakeTextField()
            return
        }
    }
}
