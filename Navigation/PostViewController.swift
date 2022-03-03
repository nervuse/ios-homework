//
//  PostViewController.swift
//  Navigation
//
//  Created by elena on 21.02.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .yellow
        self.infoButton()
    }

    private func infoButton() {
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(getInfoAction), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButtonItem
    }

    @objc private func getInfoAction() {
    dismiss(animated: true)
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
}
