//
//  Setupable.swift
//  chernovikDZ2.2
//
//  Created by elena on 14.03.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

