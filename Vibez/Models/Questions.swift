//
//  Questions.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 02/01/22.
//

import Foundation
struct Questions : Codable {
	let total : Int
	let text : String
	let chartData : [ChartData]

	/*enum CodingKeys: String, CodingKey {

		case total = "total"
		case text = "text"
		case chartData = "chartData"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		chartData = try values.decodeIfPresent([ChartData].self, forKey: .chartData)
	}*/

}
