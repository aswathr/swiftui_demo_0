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
    }
}

struct ContentView2: View {
    var body: some View {
        Text("CV2")
    }
}

struct MainView: View {
    
    @Namespace var namespace
    @State var currentPage: Int = 0
    var body: some View {
        ScrollViewReader { svProxy in
            VStack {
                GeometryReader { geoProxy in
                    ScrollView(.horizontal) {
                        HStack {
                            ContentView1()
                                .frame(width: geoProxy.size.width,
                                       height: geoProxy.size.height)
                                .id(0)
                            ContentView2()
                                .frame(width: geoProxy.size.width,
                                       height: geoProxy.size.height)
                                .id(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            currentPage = 0
                            svProxy.scrollTo(0)
                        }
                    }) {
                        GeometryReader { geoProxy in
                            Text("CV1")
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .background(Color.gray)
                                .overlay {
                                    if currentPage == 0 {
                                        Path { path in
                                            path.move(to: CGPoint(x: (geoProxy.size.width / 2) - 20, y: 0))
                                            path.addLine(to: CGPoint(x: geoProxy.size.width / 2, y: -20))
                                            path.addLine(to: CGPoint(x: (geoProxy.size.width / 2) + 20, y: 0))
                                        }
                                        .fill(Color.green)
                                        .matchedGeometryEffect(id: "ID", in: namespace)
                                    } else {
                                        EmptyView()
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Button(action: {
                        withAnimation {
                            currentPage = 1
                            svProxy.scrollTo(1)
                        }
                    }) {
                        GeometryReader { geoProxy in
                            Text("CV2")
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .background(Color.gray)
                                .overlay {
                                    if currentPage == 1 {
                                        Path { path in
                                            path.move(to: CGPoint(x: (geoProxy.size.width / 2) - 20, y: 0))
                                            path.addLine(to: CGPoint(x: geoProxy.size.width / 2, y: -20))
                                            path.addLine(to: CGPoint(x: (geoProxy.size.width / 2) + 20, y: 0))
                                        }
                                        .fill(Color.green)
                                        .matchedGeometryEffect(id: "ID", in: namespace)
                                    } else {
                                        EmptyView()
                                    }
                                }
                        }

                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 50)
            }
        }
    }
}

#Preview {
    MainView()
}
