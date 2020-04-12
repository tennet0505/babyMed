//
//  illRow.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/12/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI

struct illRow: View {
    
    var item: ill
    
    var body: some View {
        HStack{
            Text(item.name)
            Spacer()
            Text(item.date)
        }
    }
}

struct illRow_Previews: PreviewProvider {
    static var previews: some View {
        illRow(item: ill(id: " ", date: " ",  illnessWeight: " ", name: " ", symptoms: " ", treatment: " ", treatmentPhotoUri: " "))
    }
}
