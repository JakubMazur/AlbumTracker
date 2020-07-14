//
//  MainReleaseView.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import SwiftUI

struct MainReleaseView: View {
	var identifier: UInt
	@State var mainRelease: MainRelease?
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 8.0) {
				Text(self.mainRelease?.notes ?? "No Notes for this release")
					.font(.body)
					.padding(.horizontal)
			}
		}.onAppear {
			self.loadRelease(identifier: self.identifier)
		}
	}
	
	private func loadRelease(identifier: UInt) {
		MainRelease.fetch(endpoint: .release(identifier)) { (results) in
			switch results {
			case .success(let mainRelease):
				/*
					For some reason `.onAppear` is called twice while navigation. Found out that may be two reasons behind this. This is connected to "[UIContextMenuInteraction] Attempting -[UIContextMenuInteraction dismissMenu], when not in an active state. This is a client error most often caused by calling dismiss more than once during a given lifecycle. (<_UIVariableGestureContextMenuInteraction: 0x6000035818f0>)"
				
				1. Passing var to the view and modify @State property may be not good approach since it will render view twice, but Navigation should not push two views anyway... 🤔 Could be that this should just be @Binding in Artist. Since it's SwiftUI may be that I'm doing sth fishy.
				2. https://stackoverflow.com/questions/62532760/swiftui-warning-attempting-uicontextmenuinteraction-dismissmenu-when-not-i quick mock shows that in this this is really not happening for iOS 13.5. Could be then issue with beta.
				
				For further investigation. For now if it's once download will not override @State as a walkaround
				*/
				if self.mainRelease == nil {
					self.mainRelease = mainRelease
				}
			case .failure(let error):
				print(error)
			}
		}
	}
}

#if DEBUG
struct MainReleaseView_Previews: PreviewProvider {
	static var previews: some View {
		MainReleaseView(identifier: 1, mainRelease: MainRelease.testData)
	}
}
#endif
