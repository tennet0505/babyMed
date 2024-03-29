//
//  ProfileView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/12/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseDatabase

struct ProfileView: View {
    
    var child: Child
    @State var isModal = false
    @State var isModalEditChildView = false
    @EnvironmentObject var illness: Illness
    
    var body: some View {
        Form{
            Text(child.name)
            HStack(){
                WebImage(url: URL(string: child.photoUri))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70, alignment: .leading)
                    .clipShape(Circle())
                HStack(spacing: 8){
                    VStack(alignment: .leading, spacing: 8){
                        Text("Birth day:")
                            .font(.system(size: 14, weight: .medium))
                        Text(child.birthDate)
                            .font(.system(size: 14, weight: .heavy))
                        Text("Weight:")
                            .font(.system(size: 14, weight: .medium))
                        Text(child.weight)
                            .font(.system(size: 14, weight: .heavy))
                    }
                    VStack(alignment: .leading, spacing: 8){
                        Text("Sex:")
                            .font(.system(size: 14, weight: .medium))
                        Text(child.gender)
                            .font(.system(size: 14, weight: .heavy))
                        Text("Blood type:")
                            .font(.system(size: 14, weight: .medium))
                        Text(child.bloodType)
                            .font(.system(size: 14, weight: .heavy))
                    }
                }
            }
            VStack{
                Text("Past illnesses:")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(.orange)
                    .frame(maxWidth: .infinity, alignment: .center)
                Divider()
            }
            List{
                ForEach(illness.illness) { (item) in
                    illRow(ill: item, child: self.child)
                }
            }
            Section{
                Button("Add illness") {
                    self.isModal = true
                }.sheet(isPresented: $isModal) {
                    NewIllView(child: self.child)
                }.frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .font(.system(size: 20, weight: .heavy))
                    .cornerRadius(40)
            }
        }.onAppear(perform: getData)
            .onDisappear(perform: removeData)
            .navigationBarItems(trailing:
                Button("Edit") {
                    self.isModalEditChildView = true
                }.sheet(isPresented: $isModalEditChildView) {
                    EditChildView(child: self.child)
        })
    }
    func removeData(){
        self.illness.removeAll()
    }
    func getData() {
        
        let dataBase = Database.database().reference()
        dataBase.child("children").child(child.id).child("illnessList").observe(.childAdded, with: { snap  in
           
            if let getData = snap.value as? [String:Any] {
                if
                    let date = getData["date"],
                    let id = getData["idIll"],
                    let illnessWeight = getData["illnessWeight"],
                    let name = getData["name"],
                    let symptoms = getData["symptoms"],
                    let treatment = getData["treatment"],
                    let treatmentPhotoUri = getData["treatmentPhotoUri"]
                {
                    let ill1 = Ill( id: id as! String,
                                    date: date as! String,
                                    illnessWeight: "\(illnessWeight)",
                                    name: name as! String,
                                    symptoms: symptoms as! String,
                                    treatment: treatment as! String,
                                    treatmentPhotoUri: treatmentPhotoUri as! String)
                    self.illness.add(item: ill1)
                }
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(child: Child(id: " ", name: " ", userId: " ", birthDate: " ", gender: " ", bloodType: " ", photoUri: " ", weight: " "))
    }
}
