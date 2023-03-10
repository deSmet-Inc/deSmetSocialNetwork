//
//  MessengerView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 28.09.22.
//

import SwiftUI

struct MessangerView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(1 ..< 10) { i in
                    TitleRow()
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(trailing: Button(action: {
                                                print("g")
                                            }, label: {
                                                Image(systemName: "square.and.pencil")
            }))
        }
    }
}

struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessangerView()
    }
}
