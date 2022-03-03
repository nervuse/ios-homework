//
//  FeedViewController.swift
//  Navigation
//
//  Created by elena on 21.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    let postButton: UIButton = {
        let postButton = UIButton(type: .system)
        postButton.layer.cornerRadius = 12
        postButton.clipsToBounds = true
        postButton.setTitle("Перейти на пост", for: .normal)
        postButton.setTitleColor(.darkGray, for: .normal)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.backgroundColor = .green
        return postButton
    }()

    struct Post {
        var title: String
    }
    var post = Post.init(title: "Мой пост")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(postButton)
        self.setupButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = ""
    }

    private func setupButton() {
        postButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        postButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        postButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -140).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        postButton.addTarget(self, action: #selector(pressPost), for: .touchUpInside)
    }

    @objc private func pressPost() {
        let postVC = PostViewController()
        postVC.navigationItem.title = post.title
        self.navigationController?.pushViewController(postVC, animated: true)
        print("Post")
    }
}
