//
//  BrailleView.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI
import AVFoundation

struct BrailleView: View {
    var chars = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @State private var selectedChar: String?
    
    var body: some View {
        BackgroundView(
            title: "Sounds of Braille",
            subTitle: "Let's tap and listen to how each braille letter sounds on a music box score. 🎶"
        ) {
            VStack(spacing: 16) {
                ForEach(chars.chunked(into: 9), id: \.self) { row in
                    HStack(spacing: 16) {
                        Spacer()
                        ForEach(row, id: \.self) { char in
                            BrailleButton(
                                selectedChar: $selectedChar,
                                text: char
                            )
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct BrailleButton: View {
    @Binding var selectedChar: String?
    @State var audioPlayer: AVAudioPlayer!
    let text: String
    let cardWidth = UIScreen.main.bounds.width * 0.08
    let cardHeight = UIScreen.main.bounds.height * 0.14
    
    var body: some View {
        Button(action: {
            selectedChar = text
            playSound()
        }) {
            ZStack {
                CardView()
                if selectedChar == text {
                    Color.lightGreen
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
            }
            .frame(width: cardWidth, height: cardHeight)
            .overlay(
                Image("Braille_" + text)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            )
            .scaleEffect(selectedChar == text ? 1.1 : 1.0)
            .animation(.easeInOut, value: 4)
        }
    }
    
    func playSound() {
            if let soundURL = Bundle.main.url(forResource: text, withExtension: "mp3") {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer.play()
                } catch {
                    print("Error playing sound: \(error.localizedDescription)")
                }
            }
        }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    BrailleView()
}
