//
//  ContentView.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import SwiftUI

struct ContentView: View {
	@State var artist: Artist?
	
    var body: some View {
		if let artist = artist {
			HStack {
				VStack(alignment: .leading) {
					Text(artist.name).font(.headline).foregroundColor(.primary)
					Text(artist.realname).font(.subheadline).foregroundColor(.primary)
					Text(artist.profile).font(.body).foregroundColor(.secondary).padding(.top)
				}
			}
		} else {
			Text("loading...").onAppear {
				self.loadArtist()
			}
		}
    }
	
	private func loadArtist() {
		Artist.fetch { (results) in
			switch results {
			case .success(let artist):
				self.artist = artist
			case .failure(let error):
				#warning("Error handling - top bar? overlay?")
				print(error)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(artist: Artist.testData)
    }
}
