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
    
    var notchUnitSize: CGFloat = 30
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
                        withAnimation(.spring(dampingFraction: 0.5)) {
                            currentPage = 0
                        }
                        withAnimation {
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
                                        notchViewForTab(geoProxy: geoProxy)
                                        .fill(Color.gray)
                                        .matchedGeometryEffect(id: "ID", in: namespace)
                                    } else {
                                        EmptyView()
                                    }
                                }
                        }
                        
                    }
                    .buttonStyle(TabButtonStyle())
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        withAnimation(.spring(dampingFraction: 0.5)) {
                            currentPage = 1
                        }
                        withAnimation {
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
                                        notchViewForTab(geoProxy: geoProxy)
                                        .fill(Color.gray)
                                        .matchedGeometryEffect(id: "ID", in: namespace)
                                    } else {
                                        EmptyView()
                                    }
                                }
                        }
                    }
                    .buttonStyle(TabButtonStyle())
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 50)
            }
        }
    }
    
    func notchViewForTab(geoProxy: GeometryProxy) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: (geoProxy.size.width / 2) - (8 / 5 * notchUnitSize), y: 0))
            
            path.addQuadCurve(to: CGPoint(x: (geoProxy.size.width / 2) - (1 / 2 * notchUnitSize), y: -(1 / 4 * notchUnitSize)),
                              control: CGPoint(x: (geoProxy.size.width / 2) - (3 / 4 * notchUnitSize), y: 0))
            
            path.addQuadCurve(to: CGPoint(x: (geoProxy.size.width / 2) + (1 / 2 * notchUnitSize), y: -(1 / 4 * notchUnitSize)),
                              control: CGPoint(x: (geoProxy.size.width / 2), y: -(1 / sqrt(2) * notchUnitSize)))
            
            path.addQuadCurve(to: CGPoint(x: (geoProxy.size.width / 2) + (8 / 5 * notchUnitSize), y: 0),
                              control: CGPoint(x: (geoProxy.size.width / 2) + (3 / 4 * notchUnitSize), y: 0))
        }
    }
    
    private struct TabButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
}

#Preview {
    MainView()
}
