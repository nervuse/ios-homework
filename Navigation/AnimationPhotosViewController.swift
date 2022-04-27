//
//  AnimationPhotosViewController.swift
//  Navigation
//
//  Created by elena on 09.04.2022.
//

import UIKit

class AnimationPhotosViewController: UIViewController {

    struct ViewModel: ViewModelProtocol {
        var image: String
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black

        return imageView
    }()

    private var widthImageView: NSLayoutConstraint?
    private var heighImageView: NSLayoutConstraint?
    private var centerXImageView: NSLayoutConstraint?
    private var centerYImageView: NSLayoutConstraint?

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "closes")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        self.view.layoutIfNeeded()
        showImage()
    }

    private func setupSubView() {

        self.view.addSubview(imageView)
        self.view.addSubview(cancelButton)


        self.widthImageView = self.imageView.widthAnchor.constraint(equalToConstant: 138)
        self.heighImageView = self.imageView.heightAnchor.constraint(equalToConstant: 138)
        self.centerXImageView = self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.centerYImageView = self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let buttonTopConstrain = self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        let buttonTrailingConstraint = self.cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        NSLayoutConstraint.activate([self.widthImageView, self.heighImageView, self.centerXImageView, self.centerYImageView, buttonTopConstrain, buttonTrailingConstraint].compactMap( {$0} ))
    }

   func showImage() {

       NSLayoutConstraint.deactivate([self.centerXImageView, self.centerYImageView, self.widthImageView, self.heighImageView].compactMap( {$0} ))

       self.widthImageView = self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
       self.heighImageView = self.imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
       self.centerXImageView = self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
       self.centerYImageView = self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)

       NSLayoutConstraint.activate([self.centerXImageView, self.centerYImageView, self.widthImageView, self.heighImageView].compactMap( {$0} ))
       self.view.backgroundColor = .darkGray.withAlphaComponent(0.5)

       UIView.animate(withDuration: 0.5, animations: {
           self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.3) {
            self.cancelButton.alpha = 1
            }
        }
    }

    func closeShowImage() {
        NSLayoutConstraint.deactivate([self.centerYImageView, self.centerXImageView, self.widthImageView, self.heighImageView].compactMap( {$0} ))

        self.widthImageView = self.imageView.widthAnchor.constraint(equalToConstant: 138)
        self.heighImageView = self.imageView.heightAnchor.constraint(equalToConstant: 138)
        self.centerXImageView = self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.centerYImageView = self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)

        NSLayoutConstraint.activate([self.centerYImageView, self.centerXImageView, self.widthImageView, self.heighImageView].compactMap( {$0} ))
        self.view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        self.cancelButton.alpha = 0.0

        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.view.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
        }
    }

      @objc private func pressedButton() {
          closeShowImage()
      }
}

extension AnimationPhotosViewController: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.imageView.image = UIImage(named: viewModel.image)
    }
}
