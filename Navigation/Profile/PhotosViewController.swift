//
//  PhotosViewController.swift
//  chernovikDZ2.2
//
//  Created by elena on 18.03.2022.
//

import UIKit

struct Item {
    var imageName: String
}

class PhotosViewController: UIViewController {

    private var items: [Item] = [Item(imageName: "1"), Item(imageName: "2"), Item(imageName: "3"),
                                 Item(imageName: "4"), Item(imageName: "5"), Item(imageName: "6"),
                                 Item(imageName: "7"), Item(imageName: "8"), Item(imageName: "9"),
                                 Item(imageName: "10"), Item(imageName: "11"), Item(imageName: "12"),
                                 Item(imageName: "13"), Item(imageName: "14"), Item(imageName: "15"),
                                 Item(imageName: "16"), Item(imageName: "17"), Item(imageName: "18"),
                                 Item(imageName: "19"), Item(imageName: "20")]

    private enum Constants {
        static let itemCount: CGFloat = 3
    }

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        //3 элемента в ряду и 2 spacing
        let neededWidth = width - 2 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Photos Gallery"
        self.view.addSubview(collectionView)

        let topCostraint = self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8)
        let leftCostraint = self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8)
        let rightCostraint = self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8)
        let bottomCostraint = self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8)

        NSLayoutConstraint.activate([topCostraint, leftCostraint, rightCostraint, bottomCostraint])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        }

        cell.photoView.image = UIImage(named: items[indexPath.item].imageName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing

        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}

