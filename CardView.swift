//
//  CardView.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI

struct CardView: View {
    var shape = RoundedRectangle(cornerRadius: 20, style: .continuous)
    
    var body: some View {
        Color.white
        .clipShape(shape)
        .contentShape(shape)
        .shadow(color: Color.greenShadow, radius: 3, x: 1, y: 1)
    }
}

struct CardBackView: View {
    var shape = RoundedRectangle(cornerRadius: 20, style: .continuous)
    
    var body: some View {
        Color.lightGreen
        .clipShape(shape)
        .contentShape(shape)
        .shadow(color: Color.greenShadow, radius: 3, x: 1, y: 1)
    }
}

#Preview {
    CardView()
}
