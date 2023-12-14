//
//  SignInView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/11/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    @State var error = ""
    @EnvironmentObject var session: SessionManager
    
    func signIn(){
//        $session.signIn(email: email, password: password) { (result, error) in
//            if let error = error{
//                self.error = error.localizedDescription
//            }else{
//                self.email = ""
//                self.password = ""
//            }
//        }
    }
    
    var body: some View {
        
        VStack(){
            Text("Welcome back")
                .font(.system(size: 32, weight: .heavy))
            Text("Sign In")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color.gray)
                .padding(12)
            
            VStack(spacing: 20){
                TextField("Email", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 1))
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 1))
                
            }
            .padding(18)
            
            Button(action: signIn) {
                Text("Sign In")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(5)
            }
            .padding(18)
            
            if (error != ""){
                Text(error)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .padding()
                
            }
            Spacer()
            
            NavigationLink(destination: SignUpView()){
                HStack(){
                    Text("i'm new user.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("Creat new user.")
                        .font(.system(size: 16))
                        .foregroundColor(.blue)
                    
                }
            }
        }
        .padding(32)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(SessionManager())
    }
}
