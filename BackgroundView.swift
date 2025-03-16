//
//  BackgroundView.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    var content: Content
    var title: String
    var subTitle: String

    init(title: String = "", subTitle: String = "", @ViewBuilder content: () -> Content) {
        self.title = title
        self.subTitle = subTitle
        self.content = content()
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack {
                Text(subTitle)
                    .font(.title3)
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.backGray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .shadow(radius: 2)
                
                content
            }
            .padding(.vertical, 6)
        }
        .padding(.horizontal)
    }
}

