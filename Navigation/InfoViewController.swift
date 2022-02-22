//
//  InfoViewController.swift
//  Navigation
//
//  Created by elena on 21.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    let showButton: UIButton = {
        let showButton = UIButton(type: .system)
        showButton.layer.cornerRadius = 12
        showButton.clipsToBounds = true
        showButton.setTitle("Показать алерт", for: .normal)
        showButton.setTitleColor(.black, for: .normal)
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.backgroundColor = .white
        return showButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(showButton)
        self.setupButton()
    }

    private func setupButton() {
        showButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        showButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        showButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        showButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        showButton.addTarget(self, action: #selector(pressShow), for: .touchUpInside)
    }

    @objc private func pressShow() {
        print("Show")
        self.alertShow()
    }

    private func alertShow() {
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите перейти?", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "Ок", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}
