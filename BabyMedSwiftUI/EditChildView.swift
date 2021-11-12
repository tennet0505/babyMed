//
//  EditChildView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/22/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseDatabase

struct EditChildView: View {
    
    var child: Child
    @State var name = ""
    @State var birthDay = ""
    @State var gender = ""
    @State var weight = ""
    @State var bloodType = ""
    
    func textEdit(){
        name = child.name
        birthDay = child.birthDate
        gender = child.gender
        weight = child.weight
        bloodType = child.bloodType
    }
    
    var body: some View {
        Form{
            VStack(alignment: .leading, spacing: 18){
                WebImage(url: URL(string: child.photoUri))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70, alignment: .leading)
                    .clipShape(Circle())
                Section{
                    Text("Name:")
                    TextField("Name", text: $name).modifier(TextFieldModifire())
                }
                Section{
                    Text("Birth date:")
                    TextField("Birth date", text: $birthDay).modifier(TextFieldModifire())
                }
                Section{
                    Text("Sex:")
                    TextField("Sex", text: $gender).modifier(TextFieldModifire())
                }
                Section{
                    Text("Weight:")
                    TextField("Weight", text: $weight).modifier(TextFieldModifire())
                }
                Section{
                    Text("Blood type:")
                    TextField("Blood type", text: $bloodType).modifier(TextFieldModifire())
                }
                Button(action: editChild) {
                    Text("Save")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(5)
                }
            }
        }.onAppear(perform: textEdit)
    }
    func editChild() {
        print("edit child")
    }
}

struct EditChildView_Previews: PreviewProvider {
    static var previews: some View {
        EditChildView(child: Child(id: " ", name: " ", userId: " ", birthDate: " ", gender: " ", bloodType: " ", photoUri: " ", weight: " "))
    }
}
