//
//  LoginView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 02.10.22.
//

import SwiftUI

struct LoginView: View {
  
  @State private var email: String = ""
  @State private var password: String = ""
  
  @State private var error: String = ""
  @State private var showingAlert: Bool = false
  @State private var alertTitle: String = "Oh no 🥲"
  
  func errorCheck() -> String? {
    if email.trimmingCharacters(in: .whitespaces).isEmpty ||
        password.trimmingCharacters(in: .whitespaces).isEmpty 
    { return "Please fill all field and provide an profle Image" }
    
    return nil
  }
  
  func clear() {
    self.email = ""
    self.password = ""
  }
  
  func signIn() {
    if let error = errorCheck() {
      self.error = error
      self.showingAlert = true
      return
    }
    
    AuthService.signIn(email: email, password: password) { user in
      self.clear()
    } onError: { errorMessage in
      self.error = errorMessage
      self.showingAlert = true
      return
    }

  }
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 15) {
        Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
        
        VStack(alignment: .leading) {
          Text("Welcome Back").font(.system(size: 32, weight: .heavy))
          Text("Sign in").font(.system(size: 16, weight: .medium))
          
          CustomInputField(imageName: "envelope.fill", placeholderText: "E-mail", text: $email)
          
          CustomInputField(imageName: "lock.fill", placeholderText: "E-mail", SecureFieldisOff: false, text: $password)
          
          Button(action: signIn ) {
            Text("Sign in").font(.title).modifier(ButtonModifier())
          }.alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
          }
          

        }
        
        HStack {
          Text("Don't have an account?")
          NavigationLink(destination: SignUpView()) {
            Text("Create an Account")
              .bold()
          }
        }
      }
      .padding()
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
