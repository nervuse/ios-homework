//
//  Post.swift
//  chernovikDZ2.2
//
//  Created by elena on 11.03.2022.
//

import UIKit

struct Post: Decodable {

    struct Article: Decodable {
        let author: String
        let image: String
        let description: String
        var likes: Int
        var views: Int

        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }
    }

    let articles: [Article]
}


