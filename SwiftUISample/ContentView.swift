//
//  ContentView.swift
//  SwiftUISample
//
//  Created by Aswath Narayanan on 09/02/24.
//

import SwiftUI

struct ContentView1: View {
    var body: some View {
        Text("CV1")
            .fixedSize()
    }
}

struct ContentView2: View {
    var body: some View {
        Text("CV2")
            .fixedSize()
    }
}

struct MainView: View {
    var body: some View {
        ScrollViewReader { svProxy in
            VStack {
                GeometryReader { geoProxy in
                    ScrollView(.horizontal) {
                        HStack {
                            ContentView1()
                                .frame(width: geoProxy.size.width, height: geoProxy.size.height)
                                .id(1)
                            ContentView2()
                                .frame(width: geoProxy.size.width, height: geoProxy.size.height)
                                .id(2)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    .frame(maxWidth: .infinity)
                    
                }
                
                HStack {
                    Button("CV1 btn") {
                        withAnimation {
                            svProxy.scrollTo(1)
                        }
                    }

                    Button("CV2 btn") {
                        withAnimation {
                            svProxy.scrollTo(2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
