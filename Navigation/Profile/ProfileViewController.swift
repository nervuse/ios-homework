//
//  ProfileViewController.swift
//  Navigation
//
//  Created by elena on 21.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHV: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        self.viewWillLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Профиль"
    }

    override func viewWillLayoutSubviews() {
        self.view.addSubview(self.profileHV)

        let topConstraint = self.profileHV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leaidingConstraint = self.profileHV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = self.profileHV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        let heightConstraint = self.profileHV.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor)

        NSLayoutConstraint.activate([topConstraint, leaidingConstraint, trailingConstraint, heightConstraint].compactMap({ $0 }))
    }
}
