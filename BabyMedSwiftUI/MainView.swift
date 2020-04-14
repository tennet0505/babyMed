//
//  MainView.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/12/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @ObservedObject private var children = Children()
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var illness: Illness
    @State var isModal = false
    
    var body: some View {
        NavigationView(){
            Form{
                Section{
                    List(){
                        ForEach(children.children) { (item) in
                            childRow(child: item)
                        }
                    }
                }
                Section{
                    Button("Добавить") {
                        self.isModal = true
                    }.sheet(isPresented: $isModal) {
                        NewChildView()
                    }.frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .font(.system(size: 20, weight: .heavy))
                        .cornerRadius(40)
                }
                Section{
                    VStack(alignment: .center, spacing: 18){
                        Text("Welcome back! \(session.session?.displayName ?? "")")
                        Text("Email! \(session.session?.email ?? "")")
                        Text("Welcome back! \(session.session?.uid ?? "")")
                            .multilineTextAlignment(.center)
                        
                    }.padding(18)
                }
            }
            .navigationBarTitle("Children")
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing:
                Button(action: session.signOut){
                    Text("Sign Out")
                        .padding(18)
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    var session = SessionManager()
    static var previews: some View {
        MainView().environmentObject(SessionManager())
    }
}
