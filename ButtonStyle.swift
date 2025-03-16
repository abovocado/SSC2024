//
//  GreenButtonStyle.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI

struct GreenButtonStyle: ButtonStyle {
    var controlSize: ControlSize
    
    init(controlSize: ControlSize = .large) {
        self.controlSize = controlSize
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.lightGreen)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .controlSize(controlSize)
    }
}

struct GreenButton<Content: View>: View {
    var action: () -> Void
    var content: Content
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            content
                .foregroundColor(Color.darkGreen)
        }
        .buttonStyle(GreenButtonStyle())
    }
}

struct BorderButtonStyle: ButtonStyle {
    var controlSize: ControlSize
    
    init(controlSize: ControlSize = .large) {
        self.controlSize = controlSize
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.lightGreen)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.darkGreen, lineWidth: 2)
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .controlSize(controlSize)
    }
}

struct BorderButton<Content: View>: View {
    var action: () -> Void
    var content: Content
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            content
                .foregroundColor(Color.darkGreen)
        }
        .buttonStyle(BorderButtonStyle())
    }
}
