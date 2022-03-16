//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by elena on 02.03.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "котик")
        imageView.image = image
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 75.0
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sullen cat"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Be ready!"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .gray
        return label
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
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {
        self.addSubview(self.avatar)
        self.addSubview(self.nameLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.showStatusButton)

        let topImageConstreint = self.avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingImageConstraint = self.avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let widthImageConstraint = self.avatar.widthAnchor.constraint(equalToConstant: 150)
        let heightImageConstraint = self.avatar.heightAnchor.constraint(equalToConstant: 150)

        NSLayoutConstraint.activate([topImageConstreint, leadingImageConstraint, widthImageConstraint, heightImageConstraint])

        let topConstreint = self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leadingConstraint = self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 180)
        let trailingConstraint = self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightConstraint = self.nameLabel.heightAnchor.constraint(equalToConstant: 40)

        NSLayoutConstraint.activate([topConstreint, leadingConstraint, trailingConstraint, heightConstraint])

        let topLabelConstreint = self.statusLabel.topAnchor.constraint(equalTo: self.nameLabel.topAnchor, constant: 81)
        let leadingLabelConstraint = self.statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 180)
        let trailingLabelConstraint = self.statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightLabelConstraint = self.statusLabel.heightAnchor.constraint(equalToConstant: 40)

        NSLayoutConstraint.activate([topLabelConstreint, leadingLabelConstraint, trailingLabelConstraint, heightLabelConstraint])

        let topButtonConstreint = self.showStatusButton.topAnchor.constraint(equalTo: self.avatar.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightButtonConstraint = self.showStatusButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([topButtonConstreint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint])

        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    @objc private func buttonPressed() {
        if let status = self.statusLabel.text {
            print("\(status)")
        }
    }
}

