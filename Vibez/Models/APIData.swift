//
//  APIData.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 02/01/22.
//

import Foundation

struct APIData: Codable {
    let colors : [String]
    let questions : [Questions]

    /*enum CodingKeys: String, CodingKey {

        case colors = "colors"
        case questions = "questions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colors = try values.decodeIfPresent([String].self, forKey: .colors)
        questions = try values.decodeIfPresent([Questions].self, forKey: .questions)
    }*/
}
