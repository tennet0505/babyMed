//
//  NewIllView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/22/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct NewIllView: View {
    
    @State private var illName = ""
    @State var illDate = ""
    @State var weight = ""
    @State var symptoms = ""
    @State var treatment = ""
    
    
    var body: some View {
        Form{
            VStack(alignment: .leading, spacing: 18){
                HStack(spacing: 18){
                    VStack(alignment: .leading, spacing: 8){
                        Text("Название болезни:")
                        TextField("Название болезни", text: $illName).modifier(TextFieldModifire())
                    }
                    VStack(alignment: .leading, spacing: 8){
                        Text("Дата заболевания:")
                        TextField("Дата заболевания", text: $illDate).modifier(TextFieldModifire())
                    }
                }
                VStack(alignment: .leading, spacing: 8){
                    Text("Вес:")
                    TextField("Вес", text: $weight).modifier(TextFieldModifire())
                        .frame(width: 150)
                }
                Text("Симптомы:")
                TextView(text: $symptoms).frame(numLines: 5)
                Text("Лечение:")
                TextView(text: $treatment).frame(numLines: 8)
                Button(action: saveIll) {
                    Text("Сохранить")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(5)
                }
            }
        }
    }
    
    func saveIll() {
        print("save ill")
    }
}

struct NewIllView_Previews: PreviewProvider {
    static var previews: some View {
        NewIllView()
    }
}
