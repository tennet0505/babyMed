//
//  NewChildView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/13/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseStorage


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

struct NewChildView: View {
    
    let store = Storage.storage()
    let dataBase = Database.database().reference()
    let userId = UserDefaultsHelper.currentUserID ?? " "
    @State var downloadURL = ""
    @State var imgReceptPath = ""
    
    @State var name = ""
    @State var birthDate = ""
    @State var gender = ""
    @State var weight = ""
    @State var bloodType = ""
    @State var isShowAlert = false
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var inputImageURL: NSURL?
    @State var image: Image?
    @State var imageURL: NSURL?
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var session: SessionManager
    
    static var new: Child!
    
    var body: some View {
        NavigationView(){
            Form{
                VStack{
                    HStack{
                        Spacer()
                        if image != nil{
                            image?.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100, alignment:  .center)
                                .clipShape(Circle())
                        }else{
                            
                            Image("avatar_default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100, alignment:  .center)
                                .clipShape(Circle())
                            
                        }
                    }.padding(18)
                        .onTapGesture {
                            self.showingImagePicker = true
                    }
                    VStack(spacing: 8){
                        Text("Name")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Name", text: $name)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 1))
                    }
                    VStack(spacing: 8){
                        Text("Birth day")
                            .modifier(TextModifire())
                        TextField("Birth day", text: $birthDate)
                            .modifier(TextFieldModifire())
                        
                    }
                    VStack(spacing: 8){
                        Text("Sex")
                            .modifier(TextModifire())
                        TextField("Sex", text: $gender)
                            .modifier(TextFieldModifire())
                        
                    }
                    VStack(spacing: 8){
                        Text("Weight")
                            .modifier(TextModifire())
                        TextField("Weight", text: $weight)
                            .modifier(TextFieldModifire())
                    }
                    VStack(spacing: 8){
                        Text("Blood type")
                            .modifier(TextModifire())
                        TextField("Blood type", text: $bloodType)
                            .modifier(TextFieldModifire())
                        
                    }
                }
                Button(action: createNewChild) {
                    Text("Create")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(5)
                }
            }.padding(8).navigationBarTitle(Text("New Baby"), displayMode: .inline)
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
    func createNewChild(){
        
        let id = dataBase.child("children").childByAutoId().key ?? ""
        if name != "" && birthDate != "" {
            
               let new: [String : Any] = ["id": id,
                                          "name": name,
                                          "birthDate": birthDate,
                                          "gender": gender,
                                          "weight": weight,
                                          "bloodType": bloodType,
                                          "photoUri": downloadURL,
                                          "userId": userId,
                                          "illnessList": []]
               
               dataBase.child("children").child("\(id)").setValue(new)
               self.presentation.wrappedValue.dismiss()
            
            if image != nil{
                
                if downloadURL != "" {
                    dataBase.child("children").child("\(id)").updateChildValues(["photoUri": downloadURL])
                }
            }
            
        }else{
            self.isShowAlert = true
        }
       }
}


struct NewChildView_Previews: PreviewProvider {
    
    let session = SessionManager()
    
    static var previews: some View {
        NewChildView()
    }
}
