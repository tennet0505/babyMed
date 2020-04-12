//
//  ContentView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/11/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionManager
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        Group{
            if (session.session != nil){
                MainView()
            }else{
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionManager())
    }
}
