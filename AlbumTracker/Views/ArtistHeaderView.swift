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
							.layoutPriority(2)
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
