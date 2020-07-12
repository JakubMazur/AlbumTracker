//
//  AsyncImageView.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import SwiftUI

struct AsyncImageView: View {
	@ObservedObject private var apiImage: APIImage

	init(apiImage: APIImage?) {
		self.apiImage = apiImage ?? APIImage(imageType: .primary, resourceURL: nil)
		self.apiImage.load()
	}
	
	var body: some View {
		if let image = self.apiImage.image {
			Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.onDisappear {
					self.apiImage.cancel()
				}
		} else {
			Image(systemName: "photo")
		}
	}
}

struct AsyncImageView_Previews: PreviewProvider {
	static var previews: some View {
		AsyncImageView(apiImage: APIImage.testData)
	}
}
