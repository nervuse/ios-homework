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
        view.delegate = self
        return view
    }()

    private var heightConstraint: NSLayoutConstraint?

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.viewWillLayoutSubviews()
        self.setupView()
        self.tapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Профиль"
    }

    override func viewWillLayoutSubviews() {
        self.view.addSubview(button)
        let leadingButtonConstraint = self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingButtonConstraint = self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomButtonConstreint = self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let heightButtonConstraint = self.button.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([leadingButtonConstraint, trailingButtonConstraint, bottomButtonConstreint, heightButtonConstraint])
    }

    private func setupView() {
        self.view.addSubview(self.profileHV)
        let topConstraint = self.profileHV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leaidingConstraint = self.profileHV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = self.profileHV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        self.heightConstraint = self.profileHV.heightAnchor.constraint(equalToConstant: 220)

        NSLayoutConstraint.activate([topConstraint, leaidingConstraint, trailingConstraint, self.heightConstraint].compactMap({ $0 }))
    }

    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 254 : 220

        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
