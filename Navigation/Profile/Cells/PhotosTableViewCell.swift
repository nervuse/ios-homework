//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by elena on 24.03.2022.
//

import UIKit

protocol PhotosTableViewCellProtocol: AnyObject {
    func collectionTableViewCellDidTapItem()
}

class PhotosTableViewCell: UITableViewCell {

    weak var delegate: PhotosTableViewCellProtocol?

    private enum Constants {
        static let itemCount: CGFloat = 4
    }

    private lazy var photoView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var textInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        return label
    }()

    private lazy var infoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Arrows-Right")
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        return button
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        return layout
    }()

    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
        collectionView.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 4 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }

    private func setupView() {
        self.backgroundColor = .systemGray6
        self.contentView.addSubview(photoView)
        self.photoView.addSubview(infoStack)
        self.infoStack.addArrangedSubview(textInfoLabel)
        self.infoStack.addArrangedSubview(infoButton)
        self.photoView.addSubview(photoCollectionView)

        let topPhotoViewConstraint = self.photoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25)
        let leadingPhotoViewConstraint = self.photoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingPhotoViewConstraint = self.photoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomPhotoViewConstraint = self.photoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        let topInfoStackConstraint = self.infoStack.topAnchor.constraint(equalTo: self.photoView.topAnchor, constant: 12)
        let leadingInfoStackConstraint = self.infoStack.leadingAnchor.constraint(equalTo: self.photoView.leadingAnchor, constant: 12)
        let trailingInfoStackConstraint = self.infoStack.trailingAnchor.constraint(equalTo: self.photoView.trailingAnchor, constant: -12)
        let infoButtonHeightConstraint = self.infoButton.heightAnchor.constraint(equalTo: self.infoStack.heightAnchor, multiplier: 1)
        let topPhotoConstraint = self.photoCollectionView.topAnchor.constraint(equalTo: self.infoStack.bottomAnchor)
        let leadingPhotoConstraint = self.photoCollectionView.leadingAnchor.constraint(equalTo: self.photoView.leadingAnchor, constant: 12)
        let trailingPhotoConstraint = self.photoCollectionView.trailingAnchor.constraint(equalTo: self.photoView.trailingAnchor, constant: -12)
        let bottomPhotoConstraint = self.photoCollectionView.bottomAnchor.constraint(equalTo: self.photoView.bottomAnchor)
        let heightPhotoConstraint = self.photoCollectionView.heightAnchor.constraint(equalTo: self.photoView.widthAnchor, multiplier: 0.25)

        NSLayoutConstraint.activate([topPhotoViewConstraint, leadingPhotoViewConstraint, trailingPhotoViewConstraint, bottomPhotoViewConstraint, topInfoStackConstraint, leadingInfoStackConstraint, trailingInfoStackConstraint, infoButtonHeightConstraint, topPhotoConstraint, leadingPhotoConstraint, trailingPhotoConstraint, bottomPhotoConstraint, heightPhotoConstraint])
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cat.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCollectionViewCell

        cell.photoView.layer.cornerRadius = 6
        let cat = cat[indexPath.row]
        let viewModel = PhotosCollectionViewCell.ViewModel(image: cat.imageName)
        cell.setup(with: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing

        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.collectionTableViewCellDidTapItem()
    }
}


