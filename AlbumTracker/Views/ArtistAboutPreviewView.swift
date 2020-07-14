//
//  ArtistAboutView.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import SwiftUI

struct ArtistAboutPreviewView: View {
	@Binding var artist: Artist?
	@State private var revealDetails = false
	
	var body: some View {
		if let profile = artist?.profile {
			DisclosureGroup(
				content: {
					Text(profile)
						.foregroundColor(.primary)
						.font(.body)
				},
				label: {
					Text("About")
						.foregroundColor(.primary)
						.font(.headline)
				}
			).accentColor(.secondary)
		}
	}
}

struct ArtistAboutView_Previews: PreviewProvider {
	static var previews: some View {
		PreviewWrapper()
	}
	
	struct PreviewWrapper: View {
		@State(initialValue: Artist.testData) var artist: Artist?
		
		var body: some View {
			ArtistAboutPreviewView(artist: $artist)
		}
	}
}
