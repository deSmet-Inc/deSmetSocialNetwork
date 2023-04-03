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
      VStack(alignment: .trailing) {
        
        VStack(alignment: .trailing) {
          
          Text("Welcome")
            .font(.largeTitle)
            .bold()
          Text("To the future!")
            .font(.largeTitle)
            .bold()
        }
        .padding()
        .frame(width: 320, height: 240)
        .background(Color("LaunchScreenBackground"))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomLeft]))
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 15, y: 15)
        
        Spacer()
        
      
        VStack(spacing: 40){
          
          CustomInputField(imageName: "envelope.fill", placeholderText: "E-mail", text: $email)

          CustomInputField(imageName: "lock.fill", placeholderText: "Password", SecureFieldisOff: false, text: $password)

          Button(action: signIn ) {
            Text("Sign in").font(.title).bold().modifier(ButtonModifier())
          }.alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
          }

          HStack {
            Text("Don't have an account?")
            NavigationLink(destination: SignUpView()) {
              Text("Create")
                .bold()
            }
          }
          
        }
        .padding(.horizontal, 32)
        .padding(.top,45)
        
        
        Spacer()
        
      }
      .ignoresSafeArea()
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
