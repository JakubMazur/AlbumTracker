//
//  ReleaseCell.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import SwiftUI

struct ReleaseCell: View {
	var release: Release
	
	var body: some View {
		GroupBox {
			HStack(spacing: 8) {
				AsyncImageView(apiImage: release.thumbImage)
					.cornerRadius(4)
					.frame(width: 48, height: 48)
				VStack(alignment: .leading, spacing: 4) {
					Text(release.title)
						.font(.body)
						.foregroundColor(.primary)
					Text(String(release.year))
						.font(.footnote)
						.foregroundColor(.secondary)
				}
				Spacer()
			}
			HStack(alignment: .bottom) {
				Spacer()
				Text(String(release.stats.community.have))
					.font(.footnote)
				Image(systemName: "bag.fill")
				Text(String(release.stats.community.want))
					.font(.footnote)
				Image(systemName: "cart")
			}
		}
	}
}

struct ReleaseCell_Previews: PreviewProvider {
	static var previews: some View {
		ReleaseCell(release: Release.testData)
			.preferredColorScheme(.dark)
		ReleaseCell(release: Release.testData)
	}
}
