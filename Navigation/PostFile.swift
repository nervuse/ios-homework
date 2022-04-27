//
//  PostFile.swift
//  Navigation
//
//  Created by elena on 09.04.2022.
//

import UIKit

class PostFile: UIView {

    struct ViewModel: ViewModelProtocol {
        let author: String
        let image: String
        let description: String
        let likes: Int
        let views: Int
    }

    private lazy var myView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Likes: "
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.text  = "Views: "
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "closes")
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(self.myView)
        self.addSubview(self.cancelButton)
        self.myView.addSubview(self.backView)
        self.backView.addSubview(self.authorLabel)
        self.backView.addSubview(self.image)
        self.backView.addSubview(self.descriptionLabel)
        self.backView.addSubview(self.infoStack)
        self.infoStack.addArrangedSubview(self.likesLabel)
        self.infoStack.addArrangedSubview(self.viewsLabel)

        let topConstraint = self.myView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.myView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingConstraint = self.myView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let bottomConstraint = self.myView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let centerXBackViewConstraint = self.backView.centerXAnchor.constraint(equalTo: self.myView.centerXAnchor)
        let centerYBackViewConstraint = self.backView.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor)
        let leadingBackViewConstraint = self.backView.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor)
        let trailingBackViewConstraint = self.backView.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor)
        let topAuthorConstraint = self.authorLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16)
        let leadingAuthorConstraint = self.authorLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingAuthorConstraint = self.authorLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let topImageConstraint = self.image.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12)
        let leadingImageConstraint = self.image.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor)
        let trailinaImageConstraint = self.image.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor)
        let heightImageConstraint = self.image.heightAnchor.constraint(equalTo: self.backView.widthAnchor, multiplier: 1.0)
        let topDescriptionConstraint = self.descriptionLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 16)
        let leadingDescriptionConstraint = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingDescriptionConstraint = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let topInfoStackConstraint = self.infoStack.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let leadingInfoStackConstraint = self.infoStack.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingInfoStackConstraint = self.infoStack.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let bottomInfoStackConstraint = self.infoStack.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16)
        let topCancelButtonConstreint = self.cancelButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        let trailingCancelButtonConstraint = self.cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint, centerXBackViewConstraint, centerYBackViewConstraint, leadingBackViewConstraint, trailingBackViewConstraint, topAuthorConstraint, leadingAuthorConstraint, trailingAuthorConstraint, topImageConstraint, leadingImageConstraint, trailinaImageConstraint, heightImageConstraint, topDescriptionConstraint, leadingDescriptionConstraint, trailingDescriptionConstraint, topInfoStackConstraint, leadingInfoStackConstraint, trailingInfoStackConstraint, bottomInfoStackConstraint, topCancelButtonConstreint, trailingCancelButtonConstraint])
    }

    @objc private func buttonPressed() {
        removeFromSuperview()
    }
}

extension PostFile: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }

        self.authorLabel.text = viewModel.author
        self.image.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)
    }
}
