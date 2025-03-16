//
//  Color+Extension.swift
//  Braille Music
//
//  Created by SY AN on 2/15/24.
//

import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
    static let greenShadow = Color(hex: "#85B787")
    static let darkGreen = Color(hex: "#027749")
    static let lightGreen = Color(hex:"#E7F1E7")
    static let backGray = Color(hex: "#F4F4F4")
}
