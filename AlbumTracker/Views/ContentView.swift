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
	
    var body: some View {
		switch self.screenState {
		case .initial:
			ProgressView().onAppear {
				self.loadArtist()
			}.animation(.easeIn)
		case .requestSuccesfull:
			VStack(alignment: .leading) {
				ArtistHeaderView(artist: $artist)
				ArtistAboutPreviewView(artist: $artist)
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
				self.screenState = .requestSuccesfull
			case .failure(_):
				self.screenState = .connectionError
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(artist: Artist.testData, screenState: .requestSuccesfull)
		ContentView(artist: Artist.testData, screenState: .requestSuccesfull)
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
