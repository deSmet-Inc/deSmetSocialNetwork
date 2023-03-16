//
//  ProfilePhotoSelectorView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 17.10.22.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthModel
  
    @State private var profileName: String = ""
    @State private var profileSecondName: String = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack { Spacer() }
                Text("Setup Account")
                    .font(.largeTitle)
                    .bold()
                    .padding(8)
                Text("Enter information about you")
                    .font(.title)
                    .bold()
                    .opacity(0.8)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 260)
            .padding()
            .background(Color("LaunchScreenBackground"))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight, .bottomLeft]))
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 15, y: 15)
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
//                        .renderingMode(.template)
                        .scaledToFill()
//                        .foregroundColor(Color("LaunchScreenBackground"))
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color("LaunchScreenBackground"))
                        .frame(width: 180, height: 180)
                    
                }
            }
            .sheet(isPresented:  $showImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .padding(.top, 44)
            
          Text("Profile picture")
          
          VStack(alignment: .leading, spacing: 10) {
            Text("Your name:")
              .padding(.leading, 20)
            CustomInputField(imageName: "", placeholderText: "e.g. John", text: $profileName)
            Text("Your second name:")
              .padding(.leading, 20)
            CustomInputField(imageName: "", placeholderText: "e.g. Appleseed", text: $profileSecondName)
          }
          
          
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                    print("succes")
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 340, height: 60)
                        .background(Color("LaunchScreenBackground"))
                        .clipShape(Capsule())
                        .padding()
                }

            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
    
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
      ProfilePhotoSelectorView()
    }
}
