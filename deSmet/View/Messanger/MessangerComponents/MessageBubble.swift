//
//  MessageBubble.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 16.10.22.
//

import SwiftUI

struct MessageBubble: View {
    @State private var showTime = false
    var message: Message
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? Color("Gray") : Color("LaunchScreenBackground"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .padding(message.received ? .leading : .trailing, 20)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)

    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(ConversessionID: "12345",
                                       text: "Hello my friend its a first message fdnjnsdkcnvkcnskjnfnskjncdncjjjnccdcdjcndkjcnskjnfls ",
                                       received: false,
                                       timestamp: Date()))
    }
}
