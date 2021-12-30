//
//  ListUrlSession.swift
//  CupcakeCorner
//
//  Created by M H on 30/12/2021.
//

import SwiftUI

struct ListUrlSession: View {
	// MARK: props
	@State private var results = [Result]()
	
	// MARK: func
	func loadData() async {
		guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
			print("Invalid URL")
			return
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			
			if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
				results = decodedResponse.results
			}
		} catch {
			print("Invalid data")
		}
	} // f
	
	// MARK: body
    var body: some View {
		List(results, id: \.trackId) { item in
			VStack(alignment: .leading) {
				Text(item.trackName)
					.font(.headline)
				Text(item.collectionName)
			} // vs
		} // l
		.task {
			await loadData()
		} // task
    }
}

struct ListUrlSession_Previews: PreviewProvider {
    static var previews: some View {
        ListUrlSession()
    }
}
