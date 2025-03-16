//
//  SampleView.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI
import AVFoundation

struct TranslationView: View {
    @State var text: String = ""
    @State var characters: [String] = []
    @State var audioPlayer: AVAudioPlayer!
    @State var scrollTarget: Int?
    @State private var scrollPosition: CGFloat = 0
    @State var isPlaying = false
    @State var isFinished = true
    @State var currentPlayingIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Your Own Braille Music")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            HStack {
                Text("Let's transform your sentence into beautiful music box melodies. 🎼")
                    .font(.title3)
            }
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.backGray)
                        .shadow(radius: 2)
                    
                    VStack(alignment: .leading) {
                        TextField(
                            "Write your own sentence here.",
                            text: $text
                        )
                        .onChange(of: text) { newValue in
                            let filteredString = newValue.filter { $0.isLetter || $0.isNumber || $0 == " " }
                            text = filteredString
                        }
                        .font(.largeTitle)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.8))
                            .frame(height: 1)
                        
                        Text("Only alphabets and numbers are allowed.")
                            .font(.footnote)
                            .foregroundStyle(.pink)
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    isFinished = true
                    hideKeyboard()
                    addCharacters()
                    scrollTarget = 0
                }) {
                    CardView()
                        .overlay {
                            VStack {
                                Spacer()
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.largeTitle)
                                Spacer()
                                Text("Convert")
                                Spacer()
                            }
                            .foregroundStyle(text.isEmpty || isPlaying ? .gray : .black)
                        }
                }
                .disabled(text.isEmpty || isPlaying)
                .frame(width: UIScreen.main.bounds.size.width * 0.1)
                .padding(.leading)
            }
            .frame(height: UIScreen.main.bounds.size.height * 0.15)
            .padding(.vertical, 6)
            
            Spacer()
            
            GeometryReader { geo in
                HStack {
                    Image("wood")
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: screenBounds().width * 0.2, height: geo.size.height * 0.8)
                        .padding(.trailing, -10)
                        .zIndex(3)
                    
                    HStack {
                        let filteredChars = characters.filter { $0 != " " }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .foregroundStyle(Color.white)
                                    
                                    HStack(spacing: 0) {
                                        ForEach(Array(filteredChars.enumerated()), id: \.offset) { index, character in
                                            Image(character.uppercased())
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding(.trailing, -15)
                                                .padding(.leading, index == 0 ? 15 : 0)
                                        }
                                        .padding(.vertical)
                                        
                                        Image("Lines")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(.vertical)
                                    }
                                }
                                .onChange(of: scrollTarget) { target in
                                    if let target = target {
                                        scrollTarget = nil
                                        
                                        withAnimation {
                                            proxy.scrollTo(target, anchor: .leading)
                                        }
                                    }
                                }
                            }
            
                        }
                        .shadow(radius: 4)
                        .disabled(true)
                    }
                    .frame(height: geo.size.height * 0.7)
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            togglePlayback()
                        }) {
                            CardView()
                                .overlay {
                                    VStack {
                                        Spacer()
                                        
                                        if isPlaying {
                                            Image(systemName: "pause.fill")
                                                .font(.largeTitle)
                                            Spacer()
                                            Text("Pause")
                                        } else {
                                            Image(systemName: "play.fill")
                                                .font(.largeTitle)
                                            Spacer()
                                            Text("Play")
                                        }
                                        Spacer()
                                    }
                                    .foregroundStyle(characters.isEmpty ? .gray : .black)
                                }
                        }
                        .disabled(characters.isEmpty)
                        .frame(width: UIScreen.main.bounds.size.width * 0.1, height: geo.size.height * 0.8)
                        .background(Color.white.frame(height: geo.size.height))
                        .zIndex(3)
                    }
                }
                .padding(.vertical, 6)
                .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onDisappear {
            audioPlayer?.stop()
        }
    }
    
    func addCharacters() {
        characters.removeAll()
        let trimmedText = text.trimmingCharacters(in: .whitespaces)
        for char in trimmedText {
            characters.append(String(char))
        }
    }
    
    func playSoundForText() {
        let filteredCharacters = characters.filter { $0 != " " }
        DispatchQueue.global().async {
            var startIndex = 0
            
            if let currentIndex = currentPlayingIndex {
                startIndex = currentIndex + 1
            }
            for (index, character) in filteredCharacters[startIndex...].enumerated() {
                withAnimation {
                    scrollTarget = index + startIndex
                }
                if let soundURL = Bundle.main.url(forResource: String(character.uppercased()), withExtension: "mp3") {
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                        audioPlayer.play()
                        while audioPlayer.isPlaying {}
                        if index + 1 < filteredCharacters.count {
                            usleep(200000)
                        }
                    } catch {
                        print("Error playing sound: \(error.localizedDescription)")
                    }
                }
                if !isPlaying {
                    currentPlayingIndex = index + startIndex
                    isFinished = false
                    return
                }
            }
            isFinished = true
            isPlaying = false
            audioPlayer = nil
        }
    }

    func togglePlayback() {
        if isFinished {
            isFinished = false
            scrollTarget = 0
            currentPlayingIndex = nil
        }
        if isPlaying {
            audioPlayer?.stop()
        } else {
            playSoundForText()
        }
        self.isPlaying.toggle()
    }
}

#Preview {
    TranslationView()
}

extension View {
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}
