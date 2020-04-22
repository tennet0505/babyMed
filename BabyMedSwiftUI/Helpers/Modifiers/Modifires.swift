//
//  Modifires.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/22/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct TextModifire: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.orange)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
struct TextFieldModifire: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 1))
    }
}


