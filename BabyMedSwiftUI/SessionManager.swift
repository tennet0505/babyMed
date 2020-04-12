//
//  SessionManager.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/11/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class SessionManager: ObservableObject {
    
    var didChange = PassthroughSubject<SessionManager, Never>()
    
    @Published var session: User? {didSet{ self.didChange.send(self) }}
    
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user{
                self.session = User(uid: user.uid,
                                    email: user.email!,
                                    displayName: user.displayName ?? "")
                UserDefaultsHelper.currentUserID = self.session?.uid
            }
        })
    }
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.session = nil
            UserDefaultsHelper.currentUserID = nil
        } catch  {
            print("error sign out")
        }
    }
    func unbind(){
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit {
        unbind()
    }
}

struct User {
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, email: String, displayName: String ) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
