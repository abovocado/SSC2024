//
//  StoryView.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI

struct StoryView: View {
    @State private var visibleSide1 = FlipViewSide.front
    @State private var visibleSide2 = FlipViewSide.front
    @State private var visibleSide3 = FlipViewSide.front
    
    var shape = RoundedRectangle(cornerRadius: 20, style: .continuous)
    
    var body: some View {
        BackgroundView(
            title: "3 Ways to Communicate",
            subTitle: "Let's tap each card and see how we can communicate. 🗣️"
        ) {
            GeometryReader { geo in
                HStack {
                    Spacer()
                    
                    FlipView(visibleSide: visibleSide1) {
                        CardView()
                            .overlay(
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "eyes")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: geo.size.height * 0.2)
                                        .padding(.horizontal)

                                    Spacer()
                                    
                                    Text("See")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            )
                    } back: {
                        CardBackView()
                            .overlay(
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "abc")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: geo.size.height * 0.2)
                                        .padding(.horizontal)

                                    Spacer()
                                    
                                    Text("Word")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            )
                    }
                    .frame(
                        width: geo.size.width * 0.25,
                        height: geo.size.height * 0.7
                    )
                    .onTapGesture {
                        visibleSide1.toggle()
                    }
                    
                    Spacer()
                    
                    FlipView(visibleSide: visibleSide2) {
                        CardView()
                            .overlay(
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "hand.tap")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: geo.size.height * 0.2)
                                        .padding(.horizontal)

                                    Spacer()
                                    
                                    Text("Touch")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            )
                    } back: {
                        CardBackView()
                            .overlay(
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "hand.point.up.braille")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: geo.size.height * 0.2)
                                        .padding(.horizontal)

                                    Spacer()
                                    
                                    Text("Braille")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            )
                    }
                    .frame(
                        width: geo.size.width * 0.25,
                        height: geo.size.height * 0.7
                    )
                    .onTapGesture {
                        visibleSide2.toggle()
                    }
                    
                    Spacer()
                    
                    FlipView(visibleSide: visibleSide3) {
                        CardView()
                            .overlay(
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "ear")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: geo.size.height * 0.2)
                                        .padding(.horizontal)

                                    Spacer()
                                    
                                    Text("Listen")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            )
                    } back: {
                        CardBackView()
                            .overlay(
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "music.quarternote.3")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: geo.size.height * 0.2)
                                        .padding(.horizontal)

                                    Spacer()
                                    
                                    Text("Music")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            )
                    }
                    .frame(
                        width: geo.size.width * 0.25,
                        height: geo.size.height * 0.7
                    )
                    .onTapGesture {
                        visibleSide3.toggle()
                    }
                    
                    Spacer()
                }
                .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
            }
        }
    }
}

#Preview {
    StoryView()
}
