//
//  CustomInputField.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 03.10.22.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    @State  var SecureFieldisOff: Bool = true
    @Binding var text: String
    
    
    var body: some View {
        VStack {
            HStack {
                    Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if SecureFieldisOff {
                    TextField(placeholderText, text: $text)
                } else {
                    SecureField(placeholderText, text: $text)
                }
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope",
                         placeholderText: "Email",
                         SecureFieldisOff: true,
                         text: .constant(""))
    }
}
