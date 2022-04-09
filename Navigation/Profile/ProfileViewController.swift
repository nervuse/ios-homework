//
//  ProfileViewController.swift
//  chernovikDZ2.2
//
//  Created by elena on 04.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()

    private var dataSource: [Post.Article] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var tableHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
        }()

    private var heightConstraint: NSLayoutConstraint?

    private var isExpanded = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        self.fetchArticles { [weak self] articles in
            self?.dataSource = articles
            self?.tableView.reloadData()
        }

        self.tableView.tableHeaderView = tableHeaderView
        setupProfileHeaderView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }

    private func setupView() {
        self.view.addSubview(self.tableView)

        let topTableViewConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingTableViewConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingTableViewConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomTableViewConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        NSLayoutConstraint.activate([topTableViewConstraint, leadingTableViewConstraint, trailingTableViewConstraint, bottomTableViewConstraint])
    }

    private func setupProfileHeaderView() {
        self.view.backgroundColor = .lightGray
        let topConstraint = self.tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor)
        let leaidingConstraint = self.tableHeaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        let trailingConstraint = self.tableHeaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        let widthConstraint = self.tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor)
        self.heightConstraint = self.tableHeaderView.heightAnchor.constraint(equalToConstant: 220)
        let bottomConstraint = self.tableHeaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)

        NSLayoutConstraint.activate([topConstraint, leaidingConstraint, trailingConstraint, widthConstraint, heightConstraint, bottomConstraint].compactMap({ $0 }))
    }

    private func fetchArticles(completion: @escaping ([Post.Article]) -> Void) {
        if let path = Bundle.main.path(forResource: "post", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let post = try self.jsonDecoder.decode(Post.self, from: data)
                print("json data: \(post)")
                completion(post.articles)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
             fatalError("Invalid filename/path.")
        }
    }

    private func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: CGFloat(heightConstraint!.constant))).height
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.dataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            
            cell.delegate = self
            cell.selectionStyle = .none
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            return cell
        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
            cell.delegate = self
            cell.selectionStyle = .none
            let article = self.dataSource[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(author: article.author, image: article.image, description: article.description,  likes: article.likes, views: article.views)
            cell.setup(with: viewModel)
            return cell
        }
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 250 : 220

        tableView.beginUpdates()
        self.isExpanded = !textFieldIsVisible
        tableView.endUpdates()

        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: PhotosTableViewCellProtocol {

    func collectionTableViewCellDidTapItem() {
        let photoVC = PhotosViewController()
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}

extension ProfileViewController: PostTableViewCellProtocol {

    func tapImageDelegate(cell: PostTableViewCell) {
        let postFileController = PostFile()
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        self.dataSource[indexPath.row].views += 1
        let article = self.dataSource[indexPath.row]

        let viewModel = PostFile.ViewModel(
            author: article.author,
            image: article.image,
            description: article.description,
            likes: article.likes,
            views: article.views)

        postFileController.setup(with: viewModel)
        self.view.addSubview(postFileController)

        postFileController.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postFileController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postFileController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postFileController.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postFileController.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }

    func tapLikesLabelDelegate(cell: PostTableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        self.dataSource[index].likes += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}









