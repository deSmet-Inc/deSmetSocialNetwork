//
//  SignUpView.swift
//  deSmet
//
//  Created by Иван Ровков on 10.04.2023.
//

import SwiftUI

struct SignUpView: View {
  
  @State private var email: String = ""
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var profileImage: Image?
  @State private var pickedImage: Image?
  @State private var showingActionSheet: Bool = false
  @State private var showingImagePicker: Bool = false
  @State private var imageData: Data = Data()
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  @State private var error: String = ""
  @State private var showingAlert: Bool = false
  @State private var alertTitle: String = "Oh no 🥲"
  
  func loadImage() {
    guard let inputImage = pickedImage else { return }
    profileImage = inputImage
  }
  
  func errorCheck() -> String? {
    if email.trimmingCharacters(in: .whitespaces).isEmpty ||
        password.trimmingCharacters(in: .whitespaces).isEmpty ||
        username.trimmingCharacters(in: .whitespaces).isEmpty ||
        imageData.isEmpty {
      
      return "Please fill all field and provide an profle Image"
    }
    
    return nil
  }
  
  func signUp() {
    if let error = errorCheck() {
      self.error = error
      self.showingAlert = true
      return
    }
    
    AuthService.signUp(username: username, email: email, password: password, imageData: imageData) { user in
      self.clear()
    } onError: { errorMessage in
      self.error = errorMessage
      self.showingAlert = true
      return
    }

  }
  
  func clear() {
    self.email = ""
    self.username = ""
    self.password = ""
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      
      VStack(alignment: .leading) {
        
        Text("Create")
          .font(.largeTitle)
          .bold()
        Text("An new account!")
          .font(.largeTitle)
          .bold()
      }
      .padding()
      .frame(width: 320, height: 240)
      .background(Color("LaunchScreenBackground"))
      .foregroundColor(.white)
      .clipShape(RoundedShape(corners: [.bottomRight]))
      .shadow(color: .gray.opacity(0.5), radius: 10, x: 15, y: 15)
      
      Spacer()
      
      VStack(spacing: 40){
        Group {
          if profileImage != nil {
            profileImage!
              .resizable()
              .clipShape(Circle())
              .frame(width: 130, height: 130)
              .padding(.top, 20)
              .onTapGesture {
                self.showingActionSheet = true
              }
            
          } else {
            Image(systemName: "person.circle")
              .resizable()
              .clipShape(Circle())
              .frame(width: 130, height: 130)
              .padding(.top, 20)
              .shadow(color: .gray.opacity(0.5), radius: 10, x: 15, y: 15)
              .onTapGesture {
                self.showingActionSheet = true
              }
            Text("Pick a photo")
              .padding(.top, -20)
          }
        }
        
        
        Group {
          CustomInputField(imageName: "person.fill", placeholderText: "Username", text: $username)
          
          CustomInputField(imageName: "envelope.fill", placeholderText: "E-mail", text: $email)
          
          CustomInputField(imageName: "lock.fill", placeholderText: "Password", SecureFieldisOff: false, text: $password)
        }
        
        Button(action: signUp ) {
          Text("Sign up").font(.title).bold().modifier(ButtonModifier())
        }.alert(isPresented: $showingAlert) {
          Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
        }
      }
      .padding(.horizontal, 32)
      .padding(.top,45)
      
      Spacer()

    }
    .ignoresSafeArea()
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
      ImagePicker(selectedImage: self.$pickedImage, imageData: self.$imageData, showPhotoPicker: self.$showingImagePicker)
    }.actionSheet(isPresented: self.$showingActionSheet) {
      ActionSheet(title: Text(""), buttons: [
        .default(Text("Choose a photo")){
          self.sourceType = .photoLibrary
          self.showingImagePicker = true
        },
        .default(Text("Take a photo")) {
          self.sourceType = .camera
          self.showingImagePicker = true
        },
        .cancel()
      ])
    }
  }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
