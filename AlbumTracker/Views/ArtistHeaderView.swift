//
//  HeaderView.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import SwiftUI

struct ArtistHeaderView: View {
	@Binding var artist: Artist?
	
	var body: some View {
		if let artist = artist {
			HStack(alignment: .center, spacing: 8) {
				AsyncImageView(apiImage: artist.primaryImage)
					.clipShape(Circle())
					.overlay(
						Circle()
							.stroke(Color.primary)
					)
				Spacer()
				VStack(alignment: .leading) {
					Text(artist.name)
						.font(.title)
						.foregroundColor(.primary)
					Text(artist.realName)
						.font(.subheadline)
						.foregroundColor(.secondary)
				}
			}.padding(.horizontal)
		}
	}
}

struct ArtistHeaderView_Previews: PreviewProvider {
	static var previews: some View {
		PreviewWrapper()
	}
	
	struct PreviewWrapper: View {
		@State(initialValue: Artist.testData) var artist: Artist?
		
		var body: some View {
			ArtistHeaderView(artist: $artist)
		}
	}
}
