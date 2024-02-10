//
//  ContentView.swift
//  SwiftUISample
//
//  Created by Aswath Narayanan on 09/02/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: ViewModel = .init()
    @State var scrolledPageId: Int?
    @Namespace var namespace
    
    var notchUnitSize: CGFloat = 30
    var body: some View {
        
        ScrollViewReader { svProxy in

            VStack(spacing: 0) {
                
                contentView

                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring(dampingFraction: 0.5)) {
                            viewModel.currentPage = 0
                        }
                    }) {
                        tabButton("CV1", selection: 0)
                    }
                    .buttonStyle(TabButtonStyle())
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        withAnimation(.spring(dampingFraction: 0.5)) {
                            viewModel.currentPage = 1
                        }
                    }) {
                        tabButton("CV2", selection: 1)
                    }
                    .buttonStyle(TabButtonStyle())
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 50)
                .onChange(of: viewModel.currentPage) {
                    withAnimation {
                        svProxy.scrollTo(viewModel.currentPage)
                    }
                }
                .onChange(of: scrolledPageId) {
                    withAnimation(.spring(dampingFraction: 0.5)) {
                        viewModel.currentPage = scrolledPageId
                    }
                }
            }
        }
    }
    
    var contentView: some View {
        
        GeometryReader { geoProxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    Text("CV1")
                        .frame(width: geoProxy.size.width,
                               height: geoProxy.size.height)
                        .background(Color.green)
                        .id(0)
                    Text("CV2")
                        .frame(width: geoProxy.size.width,
                               height: geoProxy.size.height)
                        .background(Color.orange)
                        .id(1)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollPosition(id: $scrolledPageId)
        }
    }
    
    func tabButton(_ labelString: String, selection: Int) -> some View {
        GeometryReader { geoProxy in
            Text(labelString)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .background(Color.gray)
                .overlay {
                    if viewModel.currentPage == selection {
                        notchViewForTab(geoProxy: geoProxy)
                        .fill(Color.gray)
                        .matchedGeometryEffect(id: "ID", in: namespace)
                    } else {
                        EmptyView()
                    }
                }
        }
    }
    
    func notchViewForTab(geoProxy: GeometryProxy) -> Path {
        Path { path in
            
            path.move(to: CGPoint(x: (geoProxy.size.width / 2) - (3 / 2 * notchUnitSize), y: 0))
            
            path.addQuadCurve(to: CGPoint(x: (geoProxy.size.width / 2) - (1 / 2 * notchUnitSize), y: -(1 / 4 * notchUnitSize)),
                              control: CGPoint(x: (geoProxy.size.width / 2) - (3 / 4 * notchUnitSize), y: 0))
            
            path.addQuadCurve(to: CGPoint(x: (geoProxy.size.width / 2) + (1 / 2 * notchUnitSize), y: -(1 / 4 * notchUnitSize)),
                              control: CGPoint(x: (geoProxy.size.width / 2), y: -(1 * 0.95 / sqrt(2) * notchUnitSize)))
            
            path.addQuadCurve(to: CGPoint(x: (geoProxy.size.width / 2) + (3 / 2 * notchUnitSize), y: 0),
                              control: CGPoint(x: (geoProxy.size.width / 2) + (3 / 4 * notchUnitSize), y: 0))
        }
    }
}

fileprivate extension MainView {
    
    class ViewModel: ObservableObject {
        @Published var currentPage: Int? = 0
    }
    
    struct TabButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
}

//#Preview {
//    MainView()
//}
