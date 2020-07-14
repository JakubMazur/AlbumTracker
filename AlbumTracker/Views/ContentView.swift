//
//  ContentView.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import SwiftUI

struct ContentView: View {
	@State var artist: Artist?
	@State var screenState: ScreenState = .sucessfull
	
    var body: some View {
		switch self.screenState {
		case .sucessfull:
			NavigationView {
				List {
					ArtistHeaderView(artist: $artist)
					Group {
						ArtistAboutPreviewView(artist: $artist)
					}
					Group {
						Text("Releases")
							.foregroundColor(.primary)
							.font(.headline)
					}
					if let releases = self.artist?.masterReleases {
						ForEach(releases) { release in
							ReleaseCell(release: release)
						}
					}
				}
				.navigationBarHidden(true)
			}.onAppear {
				self.loadArtist()
			}
		case .connectionError:
			VStack {
				Image(systemName: "wifi.slash")
					.animation(.easeIn)
					.accentColor(.secondary)
				Text("No Connection")
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
		}
    }
	
	private func loadArtist() {
		Artist.fetch(endpoint: .artist(59792)) { (results) in
			switch results {
			case .success(let artist):
				self.loadCollection(for: artist)
			case .failure(_):
				self.screenState = .connectionError
			}
		}
	}
	
	private func loadCollection(for artist: Artist) {
		Collection.fetch(endpoint: .collection(artist.id)) { (results) in
			switch results {
			case .success(let collection):
				artist.masterReleases = collection.masterReleases
				self.artist = artist
			case .failure(let error):
				self.screenState = .connectionError
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(artist: Artist.testData, screenState: .sucessfull)
		ContentView(artist: Artist.testData, screenState: .sucessfull)
			.preferredColorScheme(.dark)
		ContentView(artist: Artist.testData, screenState: .connectionError)
    }
}

extension ContentView {
	enum ScreenState {
		case sucessfull
		case connectionError
	}
}
