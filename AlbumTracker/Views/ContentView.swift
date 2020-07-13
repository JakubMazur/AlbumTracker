//
//  ContentView.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import SwiftUI

struct ContentView: View {
	@State var artist: Artist?
	@State var screenState: ScreenState = .initial
	@State var collection: Collection?
	
    var body: some View {
		switch self.screenState {
		case .initial:
			ProgressView().onAppear {
				self.loadArtist()
			}.animation(.easeIn)
		case .requestSuccesfull:
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
					if let releases = self.collection?.releases {
						ForEach(releases) { release in
							ZStack {
								NavigationLink(destination: Text("something")) {
									EmptyView()
								}
								ReleaseCell(release: release)
							}
						}
					}
				}
				.navigationBarHidden(true)
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
				self.artist = artist
				self.loadCollection(for: artist)
				self.screenState = .requestSuccesfull
			case .failure(_):
				self.screenState = .connectionError
			}
		}
	}
	
	private func loadCollection(for artist: Artist) {
		Collection.fetch(endpoint: .collection(artist.id)) { (results) in
			switch results {
			case .success(let collection):
				self.collection = collection
			case .failure(let error):
				#warning("Collection loading error handling")
				print(error)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(artist: Artist.testData, screenState: .requestSuccesfull, collection: Collection.testData)
		ContentView(artist: Artist.testData, screenState: .requestSuccesfull, collection: Collection.testData)
			.preferredColorScheme(.dark)
		ContentView(artist: Artist.testData, screenState: .connectionError)
    }
}

extension ContentView {
	enum ScreenState {
		case initial
		case requestSuccesfull
		case connectionError
	}
}
