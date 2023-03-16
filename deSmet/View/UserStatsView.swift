//
//  UserStatsView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 23.10.22.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing: 24){
            VStack(spacing: 4){
                Text("807")
                    .font(.subheadline)
                    .bold()
                
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(spacing: 4){
                Text("432k")
                    .font(.subheadline)
                    .bold()
                
                Text("Folowers")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(spacing: 4){
                Text("3.7m")
                    .font(.subheadline)
                    .bold()
                
                Text("Reaction's")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
