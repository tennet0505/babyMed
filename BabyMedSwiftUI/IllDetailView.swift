//
//  IllDetailView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/15/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseDatabase

struct IllDetailView: View {
    var ill: Ill
    var child: Child
    @State private var widthDisplay: CGFloat = 0.0
    @State private var textIll = ""
    @State private var textTreatment = ""
    @State private var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    @State var isEdit = false
    @State var textIllHeight: CGFloat = 1
    @State var textTreatmentHeight: CGFloat = 1
    
    
    func textEdit(){
        textIll = ill.symptoms
        textTreatment = ill.treatment
    }
    
    var body: some View {
        
        Form(){
            Section(){
                HStack{
                    Text("Name: ")
                    Text(child.name).fontWeight(.heavy)
                }
                HStack{
                    Text("Birth Date: ")
                    Text(child.birthDate).fontWeight(.heavy)
                }
                HStack{
                    Text("Illness name: ")
                    Text(ill.name).fontWeight(.heavy)
                }
                HStack{
                    Text("Date of illness: ")
                    Text(ill.date).fontWeight(.heavy)
                }
                HStack{
                    Text("Weight on illlness day: ")
                    Text(ill.illnessWeight).fontWeight(.heavy)
                }
            }
            Section(){
                Text("Symptoms:").fontWeight(.heavy)
                if !isEdit{
                    Text(ill.symptoms)
                        .background(GeometryReader { geometry in
                            Color.clear.onAppear {
                                self.textIllHeight = CGFloat(geometry.size.height / UIFont.systemFont(ofSize: 17).lineHeight)
                                self.widthDisplay = geometry.size.width
                                print(self.textIllHeight)
                            }
                        })
                }else{
                    TextView(text: $textIll).frame(numLines: 5)
                }
            }
            Section(){
                Text("Treatment:").fontWeight(.heavy)
                if !isEdit{
                    Text(ill.treatment)
                        .background(GeometryReader { geometry in
                            Color.clear.onAppear {
                                self.textTreatmentHeight = CGFloat(geometry.size.height / UIFont.systemFont(ofSize: 17).lineHeight)
                                
                                print(self.textTreatmentHeight)
                            }
                        })
                }else{
                    TextView(text: $textTreatment).frame(numLines: 10)
                }
            }
            if self.ill.treatmentPhotoUri != "null"{
                Section(){
                    if !isEdit{
                        WebImage(url: URL(string: ill.treatmentPhotoUri))
                            .onSuccess { image, cacheType in
                                // Success
                        }
                        .resizable()
                        .indicator(.activity)
                        .animation(.easeInOut(duration: 0.5))
                        .scaledToFill()
                        .frame(width: self.widthDisplay, height: self.widthDisplay / 2, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        
                    }else{
                        VStack{
                            WebImage(url: URL(string: ill.treatmentPhotoUri))
                                .resizable()
                                .scaledToFill()
                                .frame(width: self.widthDisplay, height: self.widthDisplay / 2, alignment: .center)
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                            
                            Button(action: {
                                
                                print("Send editted data to server")
                            }, label: {
                                Text("Добавить")
                                
                            })
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.orange)
                                .font(.system(size: 20, weight: .heavy))
                        }
                    }
                    
                    NavigationLink(destination: RecieptDetail(treatmentPhotoUri: self.ill.treatmentPhotoUri)) {
                        Text("")
                    }
                }
            }
            Spacer()
        }.navigationBarItems(trailing:
            Button(action: {
                self.isEdit.toggle()
                if !self.isEdit{
                    print("Send editted data to server")
                }
            }, label: {
                if isEdit{
                    Text("Save")
                }else{
                    Text("Edit")
                }
            }))
            .onAppear(perform: textEdit)
    }
    
}

struct IllDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IllDetailView(ill: Ill(id: " ", date: " ",  illnessWeight: " ", name: " ", symptoms: " ", treatment: " ", treatmentPhotoUri: " "), child: Child(id: " ", name: " ", userId: " ", birthDate: " ", gender: " ", bloodType: " ", photoUri: " ", weight: " "))
    }
}
