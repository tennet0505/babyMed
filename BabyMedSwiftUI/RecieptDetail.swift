//
//  RecieptDetail.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/23/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecieptDetail: View {
    
    var treatmentPhotoUri = ""
    
    var body: some View {
        
        WebImage(url: URL(string: treatmentPhotoUri))
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
        .clipped()
    }
}

struct RecieptDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecieptDetail()
    }
}
