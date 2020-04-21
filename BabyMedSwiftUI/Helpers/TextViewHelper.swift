//
//  TextViewHelper.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/16/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import Combine
import SwiftUI


struct TextView: UIViewRepresentable {

    typealias UIViewType = UITextView
    @Binding var text: String
    
    var configuration = { (view: UIViewType) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        let textView = UITextView()
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.backgroundColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 17)
        
        return textView
    }
    func frame(numLines: CGFloat) -> some View{
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }

    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
    
        uiView.text = text
        uiView.delegate = context.coordinator

        configuration(uiView)
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
  
    class Coordinator: NSObject, UITextViewDelegate{
        var parent: TextView
        init(_ parent: TextView) {
            self.parent = parent
        }
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}



