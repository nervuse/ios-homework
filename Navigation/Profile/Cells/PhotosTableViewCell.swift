//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by elena on 24.03.2022.
//

import UIKit

struct Photo {
    var imageName: String
}

protocol PhotosTableViewCellProtocol: AnyObject {
    func collectionTableViewCellDidTapItem()
}

class PhotosTableViewCell: UITableViewCell {

    weak var delegate: PhotosTableViewCellProtocol?

    private var photos: [Photo] = [Photo(imageName: "1"), Photo(imageName: "2"), Photo(imageName: "3"),
                                   Photo(imageName: "4"), Photo(imageName: "5"), Photo(imageName: "6"),
                                   Photo(imageName: "7"), Photo(imageName: "8"), Photo(imageName: "9"),
                                   Photo(imageName: "10"), Photo(imageName: "11"), Photo(imageName: "12"),
                                   Photo(imageName: "13"), Photo(imageName: "14"), Photo(imageName: "15"),
                                   Photo(imageName: "16"), Photo(imageName: "17"), Photo(imageName: "18"),
                                   Photo(imageName: "19"), Photo(imageName: "20")]

    private enum Constants {
        static let itemCount: CGFloat = 4
    }

    struct ViewModel: ViewModelProtocol {
        let textLabel: String
        let imageLabel: String
        let photoImage: String
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
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
        //3 элемента в ряду и 2 spacing
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
        self.setupConstraints()
    }

    private func setupConstraints() {
        let topPhotoViewConstraint = self.photoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25)
        let leadingPhotoViewConstraint = self.photoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingPhotoViewConstraint = self.photoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomPhotoViewConstraint = self.photoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)

        let topInfoStackConstraint = self.infoStack.topAnchor.constraint(equalTo: self.photoView.topAnchor, constant: 12)
        let leadingInfoStackConstraint = self.infoStack.leadingAnchor.constraint(equalTo: self.photoView.leadingAnchor, constant: 12)
        let trailingInfoStackConstraint = self.infoStack.trailingAnchor.constraint(equalTo: self.photoView.trailingAnchor, constant: -12)
        let bottomInfoStackConstraint = self.infoStack.bottomAnchor.constraint(equalTo: self.photoCollectionView.topAnchor, constant: -12)

        let infoButtonHeightConstraint = self.infoButton.heightAnchor.constraint(equalTo: self.infoStack.heightAnchor, multiplier: 1)

        let leadingPhotoConstraint = self.photoCollectionView.leadingAnchor.constraint(equalTo: self.photoView.leadingAnchor, constant: 12)
        let trailingPhotoConstraint = self.photoCollectionView.trailingAnchor.constraint(equalTo: self.photoView.trailingAnchor, constant: -12)
        let bottomPhotoConstraint = self.photoCollectionView.bottomAnchor.constraint(equalTo: self.photoView.bottomAnchor, constant: -12)
        let heightPhotoConstraint = self.photoCollectionView.heightAnchor.constraint(equalTo: self.photoView.widthAnchor, multiplier: 0.25)

        NSLayoutConstraint.activate([topPhotoViewConstraint, leadingPhotoViewConstraint, trailingPhotoViewConstraint, bottomPhotoViewConstraint, topInfoStackConstraint, leadingInfoStackConstraint, trailingInfoStackConstraint, bottomInfoStackConstraint, infoButtonHeightConstraint, leadingPhotoConstraint, trailingPhotoConstraint, bottomPhotoConstraint, heightPhotoConstraint])
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        }
        cell.photoView.layer.cornerRadius = 6
        cell.photoView.image = UIImage(named: photos[indexPath.item].imageName)
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


