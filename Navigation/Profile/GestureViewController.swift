//
//  GestureViewController.swift
//  Navigation
//
//  Created by elena on 14.04.2022.
//

import UIKit

class GestureViewController: UIViewController {

    private lazy var myView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.alpha = 0
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()

    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "котик")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 69.0
        imageView.isUserInteractionEnabled = true // игнорирует касание false
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "closes")
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.alpha = 0
        button.isHidden = true   //скрытие
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let tapGestureRecognizer = UITapGestureRecognizer()

    private var widthImageConstraint: NSLayoutConstraint?
    private var heightImageConstraint: NSLayoutConstraint?
    private var topImageConstreint: NSLayoutConstraint?
    private var leadingImageConstraint: NSLayoutConstraint?

    private var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
  //      self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.0)

        self.setupView()
        self.setupGesture()
    }

    private func setupView() {
        self.view.addSubview(myView)
        self.view.addSubview(avatar)
        self.view.bringSubviewToFront(avatar)
        self.view.addSubview(cancelButton)

        let centerXViewConstraint = self.myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerYViewConstraint = self.myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let widthConstraint = self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        let heightConstraint = self.myView.heightAnchor.constraint(equalTo: self.view.heightAnchor)

        NSLayoutConstraint.activate([centerXViewConstraint, centerYViewConstraint, widthConstraint, heightConstraint])

        self.topImageConstreint = self.avatar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30)
        self.leadingImageConstraint = self.avatar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        self.widthImageConstraint = self.avatar.widthAnchor.constraint(equalToConstant: 138)
        self.heightImageConstraint = self.avatar.heightAnchor.constraint(equalToConstant: 138)

        NSLayoutConstraint.activate([self.topImageConstreint, self.leadingImageConstraint, self.widthImageConstraint, self.heightImageConstraint].compactMap({ $0 }))

        let topCancelButtonConstreint = self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        let trailingCancelButtonConstraint = self.cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([topCancelButtonConstreint, trailingCancelButtonConstraint])

    }

    private func setupGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.avatar.addGestureRecognizer(self.tapGestureRecognizer)
        cancelButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    @objc private func handleTapGesture(_ gestureRecogniser: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecogniser else { return }

        self.isExpanded.toggle()

        if self.isExpanded {
            self.cancelButton.isHidden = false
            self.myView.isHidden = false
        }

//        NSLayoutConstraint.deactivate([self.topImageConstreint, self.leadingImageConstraint, self.widthImageConstraint, self.heightImageConstraint].compactMap( {$0} ))
//
//        self.widthImageConstraint = self.avatar.widthAnchor.constraint(equalTo: self.view.widthAnchor)
//        self.heightImageConstraint = self.avatar.heightAnchor.constraint(equalTo: self.view.widthAnchor)
//        self.topImageConstreint = self.avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        self.leadingImageConstraint = self.avatar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//
//        NSLayoutConstraint.activate([self.topImageConstreint, self.leadingImageConstraint, self.widthImageConstraint, self.heightImageConstraint].compactMap( {$0} ))

        self.heightImageConstraint?.constant = self.isExpanded ? self.view.bounds.height : 138
        self.widthImageConstraint?.constant = self.isExpanded ? self.view.bounds.width : 138

        NSLayoutConstraint.deactivate([ self.topImageConstreint, self.leadingImageConstraint].compactMap( {$0} ))

        UIView.animate(withDuration: 0.5) {
      //      self.avatar.layer.cornerRadius = 0.0  //Задание под звездочкой
            self.myView.alpha = self.isExpanded ? 0.5 : 0
            self.view.layoutIfNeeded()
        } completion: { _ in
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.cancelButton.alpha = 1.0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.cancelButton.isHidden = !self.isExpanded
        }
    }

    @objc private func buttonPressed() {

        if self.isExpanded {
            self.cancelButton.isHidden = false
            self.myView.isHidden = false
        }

        self.isExpanded.toggle()

        NSLayoutConstraint.deactivate([self.topImageConstreint, self.leadingImageConstraint, self.widthImageConstraint, self.heightImageConstraint].compactMap( {$0} ))

            self.widthImageConstraint = self.avatar.widthAnchor.constraint(equalToConstant: 138)
            self.heightImageConstraint = self.avatar.heightAnchor.constraint(equalToConstant: 138)
            self.topImageConstreint = self.avatar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30)
            self.leadingImageConstraint = self.avatar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)

        NSLayoutConstraint.activate([self.topImageConstreint, self.leadingImageConstraint, self.widthImageConstraint, self.heightImageConstraint].compactMap( {$0} ))

        UIView.animate(withDuration: 0.3, delay: 0.3) {
            self.cancelButton.alpha = 0.0
            self.view.layoutIfNeeded()
        } completion: { _ in
        }

        UIView.animate(withDuration: 0.5) {
            self.myView.alpha = self.isExpanded ? 0.5 : 0
      //      self.avatar.layer.cornerRadius = 69.0  //Задание под звездочкой
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
    }
}

