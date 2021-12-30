//
//  ResultResponse.swift
//  CupcakeCorner
//
//  Created by M H on 30/12/2021.
//

import Foundation


struct Response:Codable {
	var results: [Result]
}

struct Result: Codable {
	var trackId: Int
	var trackName: String
	var collectionName: String
}
