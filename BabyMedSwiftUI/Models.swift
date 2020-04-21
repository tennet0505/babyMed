//
//  Models.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/12/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Combine

class Children: ObservableObject {
    
    @Published var children = [Child]()
    @Published var illness = [Ill]()
    
    @EnvironmentObject var session: SessionManager
    init() {
        
        //DataBase
        let dataBase = Database.database().reference()
        dataBase.child("children").observe(.childAdded, with: { snap  in
            
            if let getData = snap.value as? [String:Any] {
                if
                    let name = getData["name"],
                    let birthDay = getData["birthDate"],
                    let bloodType = getData["bloodType"],
                    let weight = getData["weight"],
                    let userId = getData["userId"],
                    let photoUri = getData["photoUri"],
                    let gender = getData["gender"],
                    let id = getData["id"]
                {
                    if let uid = UserDefaultsHelper.currentUserID{
                        if uid == userId as? String{
                            let kid = Child(id: id as! String,
                                            name: name as! String,
                                            userId: userId as! String,
                                            birthDate: birthDay  as! String,
                                            gender: gender as! String,
                                            bloodType: bloodType as! String,
                                            photoUri: photoUri as! String,
                                            weight: "\(weight)")
                            
                            self.children.append(kid)
                        }
                    }
                }
            }
        })
        //CloudDB
        //        let db = Firestore.firestore()
        //        db.collection("children").addSnapshotListener { (snap, error) in
        //            if error != nil{
        //                print(error?.localizedDescription ?? "")
        //                return
        //            }else{
        //                for kid in snap!.documentChanges{
        //                    let id = kid.document.documentID
        //                    let name = kid.document.get("name") as! String
        //                    let userId = kid.document.get("userId") as! String
        //                    let gender = kid.document.get("gender") as! String
        //                    let bloodType = kid.document.get("bloodType") as! String
        //                    let photoUri = kid.document.get("photoUri") as! String
        //                    let weight = kid.document.get("weight") as! String
        //
        //                    let kid = child(id: id,
        //                                    name: name ,
        //                                    userId: userId,
        //                                    gender: gender,
        //                                    bloodType: bloodType,
        //                                    photoUri: photoUri,
        //                                    weight: weight)
        //
        //                    self.children.append(kid)
        //                }
        //            }
        //        }
    }
}
class Illness: ObservableObject {
    
    @Published var illness = [Ill]()
    @EnvironmentObject var session: SessionManager
    
    func add(item: Ill) {
        illness.append(item)
    }
    func removeAll() {
        illness.removeAll()
    }
}

//class NewChild: ObservableObject {
//    
//    var didChange = PassthroughSubject<NewChild, Never>()
//    
//    @Published var child: Child?{didSet{ self.didChange.send(self) }}
//    @EnvironmentObject var session: SessionManager
//    
//    func addNew(child: Child) {
//        let dataBase = Database.database().reference()
//        dataBase.child("children").child("\(child.id)").setValue(child)
//    }
//}

struct Child: Identifiable, Codable {
    var id: String
    var name: String
    var birthDate: String
    var userId: String
    var gender: String
    var bloodType: String
    var photoUri: String
    var weight: String
        
    init(id: String,
         name: String,
         userId: String,
         birthDate: String,
         gender: String,
         bloodType: String,
         photoUri: String,
         weight: String) {
        
        self.id = id
        self.name = name
        self.userId = userId
        self.birthDate = birthDate
        self.gender = gender
        self.bloodType = bloodType
        self.photoUri = photoUri
        self.weight = weight
    }
}


struct Ill: Identifiable {
    var id: String
    var date: String
    var illnessWeight: String
    var name: String
    var symptoms: String
    var treatment: String
    var treatmentPhotoUri: String
    
    init(id: String,
         date: String,
         illnessWeight: String,
         name: String,
         symptoms: String,
         treatment: String,
         treatmentPhotoUri: String){
        
        self.id = id
        self.date = date
        self.illnessWeight = illnessWeight
        self.name = name
        self.symptoms = symptoms
        self.treatment = treatment
        self.treatmentPhotoUri = treatmentPhotoUri
    }
    
}
