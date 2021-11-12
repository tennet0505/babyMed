//
//  NewIllView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/22/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseStorage

struct NewIllView: View {
    
    var child: Child
    let store = Storage.storage()
    let dataBase = Database.database().reference()
    let userId = UserDefaultsHelper.currentUserID ?? " "
    @State var downloadURL = ""
    @State var imgReceptPath = ""
    
    @State var illName = ""
    @State var illDate = ""
    @State var weight = ""
    @State var symptoms = ""
    @State var treatment = ""
    
    @State var isShowAlert = false
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var inputImageURL: NSURL?
    @State var image: Image?
    @State var imageURL: NSURL?
    
    @Environment(\.presentationMode) var presentation

    
    
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
                Button(action: createNewIll) {
                    Text("Сохранить")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(5)
                }
            }
            HStack(alignment: .center){
                if image != nil{
                    image?.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 2, alignment: .center)
                        .clipped()
                }else{
                    Image("avatar_default")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 2, alignment: .center)
                        .clipped()
                }
            }.onTapGesture {
                self.showingImagePicker = true
            }
            
        }.alert(isPresented: $isShowAlert) {
            
            Alert(title: Text("Alert"), message: Text("Fill all fields"), primaryButton: .default(Text("Ok")){  print(Text("click ok"))
                }, secondaryButton: .cancel())
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, imageURL: self.$imageURL)
        }
    }
    func loadImage() {
        guard let inputImage = inputImage, let inputImageURL = imageURL  else { return }
        image = Image(uiImage: inputImage)
        imageURL = inputImageURL
        imgReceptPath = inputImageURL.lastPathComponent ?? " "
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        store.reference().child("images/\(imgReceptPath)").putData(inputImage.jpegData(compressionQuality: 0.35)!, metadata: metaData) { (_, error)  in
            if error != nil{
                print(error?.localizedDescription)
                return
            }else{
                self.store.reference().child("images/\(self.imgReceptPath)").downloadURL { (url, error) in
                    if error != nil{
                        print(error?.localizedDescription)
                        return
                    }else{
                        DispatchQueue.main.async {
                            if  let URLdownload = url {
                                self.downloadURL = URLdownload.absoluteString
                                print(self.downloadURL)
                            }
                        }
                    }
                }
            }
        }
    }
    func createNewIll() {
        
        let id = child.id//dataBase.child("children").childByAutoId().key ?? ""
        let idIll = dataBase.child("children").child(id).child("illnessList").childByAutoId().key ?? ""
        if illName != "" && illDate != "" && weight != "" && symptoms != "" && treatment != ""{
            
            let illNew: [String : Any] = ["idIll": idIll,
                                          "name": illName,
                                          "date": illDate,
                                          "symptoms": symptoms,
                                          "treatmentPhotoUri": downloadURL,
                                          "treatment": treatment,
                                          "illnessWeight": Int(weight) as Any]
            
            dataBase.child("children").child(id).child("illnessList").child("\(idIll)").setValue(illNew)
            self.presentation.wrappedValue.dismiss()
            if image != nil{
                
                if downloadURL != "" {
                        dataBase.child("children").child(id).child("illnessList").child("\(idIll)").updateChildValues(["treatmentPhotoUri": downloadURL])
                    }
                }
                
            }else{
                self.isShowAlert = true
            }
        }
    }

struct NewIllView_Previews: PreviewProvider {
    static var previews: some View {
        NewIllView(child: Child(id: " ", name: " ", userId: " ", birthDate: " ", gender: " ", bloodType: " ", photoUri: " ", weight: " "))
    }
}
