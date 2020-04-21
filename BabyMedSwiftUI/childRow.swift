//
//  childRow.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/12/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseDatabase


struct childRow: View {
    
    var child: Child    
   
    var body: some View {
        NavigationLink(destination: ProfileView(child: child)){
            HStack(){
                WebImage(url: URL(string: child.photoUri))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment:  .center)
                    .cornerRadius(10)//clipShape(Circle())
                    .clipped()
                
                Spacer()
                Text(child.name)
            }
        }
    }
}


struct childRow_Previews: PreviewProvider {
    
    static var previews: some View {
        childRow(child: Child(id: " ", name: " ", userId: " ", birthDate: " ", gender: " ", bloodType: " ", photoUri: " ", weight: " "))
    }
}
