//
//  CharData.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 02/01/22.
//

import Foundation
struct ChartData : Codable {
	let text : String?
	let percetnage : Int?

	/*enum CodingKeys: String, CodingKey {

		case text = "text"
		case percetnage = "percetnage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		percetnage = try values.decodeIfPresent(Int.self, forKey: .percetnage)
	}*/

}
