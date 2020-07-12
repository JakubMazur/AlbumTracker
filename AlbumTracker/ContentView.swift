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
			VStack(alignment: .leading) {
				HeaderView(artist: $artist)
				Text("About").font(.headline)
				Text(artist.profile).font(.body)
					.foregroundColor(.primary)
					.padding(.horizontal)
					.lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
			}
		} else {
			Text("loading...").onAppear {
				self.loadArtist()
			}
		}
    }
	
	private func loadArtist() {
		Artist.fetch(endpoint: .artist(59792)) { (results) in
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
		ContentView(artist: Artist.testData)
			.preferredColorScheme(.dark)
    }
}

struct HeaderView: View {
	@Binding var artist: Artist?
	
	var body: some View {
		if let artist = artist {
			ZStack {
				HStack {
					AsyncImageView(apiImage: artist.primaryImage)
						.clipShape(Circle())
						.overlay(
							Circle()
								.stroke(Color.primary)
						)
					VStack(alignment: .leading) {
						Text(artist.name)
							.font(.title)
							.foregroundColor(.primary)
							.layoutPriority(1)
						Text(artist.realName)
							.font(.subheadline)
							.foregroundColor(.secondary)
							.layoutPriority(1)
					}
					.padding()
				}
				.padding(.horizontal)
			}.background(
				Rectangle().fill(Color("headerBackground"))
			)
		}
	}
}
