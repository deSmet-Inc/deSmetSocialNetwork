//
//  ChatView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 16.10.22.
//

import SwiftUI

struct ChatView: View {
//    @Binding var showChatView: Bool
//    var animation: Namespace.ID
    var MessageArray = ["Hello", "How are u ?", "Can you come with us to the Hellowinn ?", "We wait to your answer"]
    
    
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                
                ScrollView {
                    ForEach(MessageArray, id: \.self) { text in MessageBubble(message: Message(ConversessionID: "12345",
                                text: text,
                                received: false,
                                timestamp: Date()))
                    }
                }
                .padding(.top, 10)
                .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
            }
            .background(Color("LaunchScreenBackground"))
//            .opacity(showChatView ? 1 : 0)
            MessageField()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
