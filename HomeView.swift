//
//  HomeView.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI

struct HomeView: View {
    @State var isShowingContentView = false
    @State private var flashWarning = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("Cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 100)
                
                Spacer()
                
                BorderButton(action: {
                    isShowingContentView = true
                }) {
                    Text("    Start    ")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .navigationDestination(
                    isPresented: $isShowingContentView
                ) {
                    ContentView(
                        isShowingContentView: $isShowingContentView
                    )
                }
                .padding(.vertical)
                
                Label("Please fix the screen in landscape mode", systemImage: "lock.rotation")
                    .font(.title3)
                    .padding(.top)
                    .opacity(flashWarning ? 0.8 : 0.2)
                
                Label("Please turn on the sound.", systemImage: "speaker.wave.2.fill")
                    .font(.title3)
                    .opacity(flashWarning ? 0.8 : 0.2)
                
                Spacer()
            }
            .padding()
            .onAppear {
                withAnimation(Animation.easeIn(duration: 1.0).repeatForever(autoreverses: true)) {
                    self.flashWarning.toggle()
                }
            }
        }
        .environment(\.colorScheme, .light)
    }
}
