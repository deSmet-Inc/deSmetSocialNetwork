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
    VStack {
      VStack(spacing: 15) {
        Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
        
        VStack(alignment: .leading) {
          Text("Welcome Back").font(.system(size: 32, weight: .heavy))
          Text("Sign up").font(.system(size: 16, weight: .medium))
          
          VStack {
            Group {
              if profileImage != nil {
                profileImage!.resizable()
                  .clipShape(Circle())
                  .frame(width: 100, height: 100)
                  .padding(.top, 20)
                  .onTapGesture {
                    self.showingActionSheet = true
                  }
              } else {
                Image(systemName: "person.fill")
                  .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
                    .onTapGesture {
                      self.showingActionSheet = true
                    }
              }
            }
          }
          
          Group {
            CustomInputField(imageName: "person.fill", placeholderText: "Username", text: $username)
            
            CustomInputField(imageName: "envelope.fill", placeholderText: "E-mail", text: $email)
            
            CustomInputField(imageName: "lock.fill", placeholderText: "Password", SecureFieldisOff: false, text: $password)
          }
          
          Button(action: signUp ) {
            Text("Sign up").font(.title).modifier(ButtonModifier())
          }.alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
          }
          
        }
        
      }
      .padding()
    }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
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
