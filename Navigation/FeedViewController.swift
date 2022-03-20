//
//  FeedViewController.swift
//  Navigation
//
//  Created by elena on 21.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressPost), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()

    private lazy var postTwoButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressPost), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()

    struct Post {
        var title: String
    }

    var post = Post.init(title: "Мой пост")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(buttonsStackView)
        self.buttonsStackView.addArrangedSubview(postButton)
        self.buttonsStackView.addArrangedSubview(postTwoButton)

        let centrStackConstreint = self.buttonsStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let leidingStackConstraint = self.buttonsStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let trailingStackConstraint = self.buttonsStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let heightStackConstraint = self.buttonsStackView.heightAnchor.constraint(equalToConstant: 110)

        NSLayoutConstraint.activate([centrStackConstreint, leidingStackConstraint, trailingStackConstraint, heightStackConstraint])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = ""
    }

    @objc private func pressPost() {
        let postVC = PostViewController()
        postVC.navigationItem.title = post.title
        self.navigationController?.pushViewController(postVC, animated: true)
        print("Post")
    }
}
