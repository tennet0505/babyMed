//
//  SignUpView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/11/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var error = ""
    @EnvironmentObject var session: SessionManager
    
    func signUp(){
    
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error{
                self.error = error.localizedDescription
            }else{
                self.email = ""
                self.password = ""
            }
        }
    }
    
    
    var body: some View {
        
        VStack{
            Text("Creat Account")
                .font(.system(size: 32, weight: .heavy))
            Text("SignUp to get started")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            
            VStack(spacing: 18){
                TextField("Email", text: $email)
                    .font(.system(size:14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue, lineWidth: 1))
                SecureField("Password", text: $password)
                    .font(.system(size:14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue, lineWidth: 1))
            }
            .padding(18)
            
            Button(action: signUp){
                Text("Creat Account")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            .padding(18)
            
            if (error != ""){
                Text(error)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.red)
                    .padding()
            }
            Spacer()
        }
        .padding(32)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionManager())
    }
}
