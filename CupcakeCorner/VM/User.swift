//
//  User.swift
//  CupcakeCorner
//
//  Created by M H on 30/12/2021.
//

import Foundation

class User:  ObservableObject, Codable {
	
	enum CodingKeys: CodingKey {
		case name
	}
	
	@Published var name = "Paul"
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
	} // f
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
	} // f
}
