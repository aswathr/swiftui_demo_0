//
//  SwiftUISampleApp.swift
//  SwiftUISample
//
//  Created by Aswath Narayanan on 09/02/24.
//

import SwiftUI

@main
struct SwiftUISampleApp: App {
    @State var searchText: String = ""

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .navigationTitle("SwiftUI sample")
                    .navigationBarTitleDisplayMode(.automatic)
            }
        }
    }
}
