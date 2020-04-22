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
                    Text("Имя:")
                    TextField("Имя", text: $name).modifier(TextFieldModifire())
                }
                Section{
                    Text("День рождения:")
                    TextField("День рождения", text: $birthDay).modifier(TextFieldModifire())
                }
                Section{
                    Text("Пол:")
                    TextField("Пол", text: $gender).modifier(TextFieldModifire())
                }
                Section{
                    Text("Вес:")
                    TextField("Вес", text: $weight).modifier(TextFieldModifire())
                }
                Section{
                    Text("Группа крови:")
                    TextField("Группа крови", text: $bloodType).modifier(TextFieldModifire())
                }
                Button(action: editChild) {
                    Text("Сохранить")
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
