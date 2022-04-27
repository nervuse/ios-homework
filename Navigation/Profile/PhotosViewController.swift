//
//  PhotosViewController.swift
//  chernovikDZ2.2
//
//  Created by elena on 18.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {

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
        let neededWidth = width - 2 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)

        let topCostraint = self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8)
        let leftCostraint = self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8)
        let rightCostraint = self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8)
        let bottomCostraint = self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8)

        NSLayoutConstraint.activate([topCostraint, leftCostraint, rightCostraint, bottomCostraint])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Photo Gallery"
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cat.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        }

        let cat = cat[indexPath.row]
        let viewModel = PhotosCollectionViewCell.ViewModel(image: cat.imageName)
        cell.setup(with: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing

        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let animationPhotosViewController = AnimationPhotosViewController()

        let cat = cat[indexPath.row]
        let viewModel = AnimationPhotosViewController.ViewModel(image: cat.imageName)
        animationPhotosViewController.setup(with: viewModel)

        self.view.addSubview(animationPhotosViewController.view)
        self.addChild(animationPhotosViewController)
        animationPhotosViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animationPhotosViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationPhotosViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationPhotosViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            animationPhotosViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        animationPhotosViewController.didMove(toParent: self)
    }
}

