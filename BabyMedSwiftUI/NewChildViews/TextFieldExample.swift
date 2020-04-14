//
//  TextFieldExample.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/13/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct TextFieldExample: View {
    
    @State private var name = ""
    var nameText: String
    
    var body: some View {
        VStack(spacing: 8){
            Text("\(nameText)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Name", text: $name)
                .font(.system(size: 14))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 1))
        }
    }
}

struct TextFieldExample_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldExample(nameText: " ")
    }
}
