//
//  AuthView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/11/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct AuthView: View {
  
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        NavigationView(){
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionManager())
    }
}
