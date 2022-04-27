//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by elena on 24.03.2022.
//

import UIKit

protocol PostTableViewCellProtocol: AnyObject {

    func tapImageDelegate(cell: PostTableViewCell)
    func tapLikesLabelDelegate(cell: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {

    struct ViewModel: ViewModelProtocol {
        let author: String
        let image: String
        let description: String
        let likes: Int
        let views: Int
    }

    weak var delegate: PostTableViewCellProtocol?

    private var tapLikesLabelGestureRecognizer = UITapGestureRecognizer()
    private var tapImageGestureRecognizer = UITapGestureRecognizer()

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
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
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.image.image = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }

    private func setupView() {
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.authorLabel)
        self.backView.addSubview(self.image)
        self.backView.addSubview(self.descriptionLabel)
        self.backView.addSubview(self.infoStack)
        self.infoStack.addArrangedSubview(self.likesLabel)
        self.infoStack.addArrangedSubview(self.viewsLabel)

        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
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

        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint, topAuthorConstraint, leadingAuthorConstraint, trailingAuthorConstraint, topImageConstraint, leadingImageConstraint, trailinaImageConstraint, heightImageConstraint, topDescriptionConstraint, leadingDescriptionConstraint, trailingDescriptionConstraint, topInfoStackConstraint, leadingInfoStackConstraint, trailingInfoStackConstraint, bottomInfoStackConstraint])
    }
}

extension PostTableViewCell: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }

        self.authorLabel.text = viewModel.author
        self.image.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)
    }
}

extension PostTableViewCell {

    private func setupGesture() {
        self.tapLikesLabelGestureRecognizer.addTarget(self, action: #selector(self.likesHandleGesture(_:)))
        self.likesLabel.addGestureRecognizer(self.tapLikesLabelGestureRecognizer)
        self.likesLabel.isUserInteractionEnabled = true

        self.tapImageGestureRecognizer.addTarget(self, action: #selector(self.ImageHandleGesture(_:)))
        self.image.addGestureRecognizer(self.tapImageGestureRecognizer)
        self.image.isUserInteractionEnabled = true
    }


    @objc func likesHandleGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapLikesLabelGestureRecognizer === gestureRecognizer else { return }
        delegate?.tapLikesLabelDelegate(cell: self)
    }

    @objc func ImageHandleGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapImageGestureRecognizer === gestureRecognizer else { return }
        delegate?.tapImageDelegate(cell: self)
    }
}

