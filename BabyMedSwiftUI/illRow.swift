//
//  illRow.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/12/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct illRow: View {
    
    var ill: Ill
    var child: Child
    
    var body: some View {
        NavigationLink(destination: IllDetailView(ill: ill, child: child)){
            HStack{
                Text(ill.name)
                Spacer()
                Text(ill.date)
            }
        }
    }
}

struct illRow_Previews: PreviewProvider {
    static var previews: some View {
        illRow(ill: Ill(id: " ", date: " ",  illnessWeight: " ", name: " ", symptoms: " ", treatment: " ", treatmentPhotoUri: " "), child: Child(id: " ", name: " ", userId: " ", birthDate: " ", gender: " ", bloodType: " ", photoUri: " ", weight: " "))
    }
}
