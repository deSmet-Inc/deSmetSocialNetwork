//
//  LoginView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 02.10.22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthModel

    @State private var isAuth = true
    @State private var isHomeScreenView = false
    
    @State private var Email = ""
    @State private var Password = ""
    @State private var RepeatPassword = ""
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    var body: some View {
        
        Group {
    
            // no user logged in
            if viewModel.userSession == nil {
                loginInterfaceView
            } else {
                MainTabView()
            }
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthModel())
    }
}



extension LoginView {
    var loginInterfaceView: some View {
        VStack {

            VStack(alignment: isAuth ? .leading : .trailing) {
                HStack { Spacer() }
                
                Text(isAuth ? "Hi." : "Welcome")
                    .font(.largeTitle)
                    .bold()
                    .animation(Animation.easeIn(duration: 0.5))

                Text(isAuth ? "Welcome back!" : "To The Future!")
                    .font(.largeTitle)
                    .bold()
                    .animation(Animation.easeInOut(duration: 0.6))
                

//                Image("NameLogo")
//                    .resizable()
//                    .frame(width: 120, height: 60)
//                    .foregroundColor(.white)
//                    .padding()
//
            }
            .frame(height: 260)
            .padding()
            .background(Color("LaunchScreenBackground"))
            .foregroundColor(.white)
            .clipShape(isAuth ? RoundedShape(corners: [.bottomRight]) : RoundedShape(corners: .bottomLeft))
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 15, y: 15)
            
            VStack(spacing: 40){
                
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 SecureFieldisOff: true,
                                 text: $Email)
                
                CustomInputField(imageName: "lock",
                                 placeholderText: "Password",
                                 SecureFieldisOff: false,
                                 text: $Password)
          
                
                if isAuth == false {
                    CustomInputField(imageName: "lock",
                                     placeholderText: "Repeat Password",
                                     SecureFieldisOff: false,
                                     text: $RepeatPassword)
                }
 
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            if isAuth{
                HStack{
                    Spacer()
                    
                    NavigationLink {
                        Text("ForgotPasswordView...")
                    } label: {
                        Text("Forgot Password ? ")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.init("LaunchScreenBackground"))
                            .padding(.top, 12)
                            .padding(.trailing, 24)
                    }
                }
            }
            
            HStack{
                Button {
                    if isAuth {
                        print("Authorization")
                        viewModel.LoginUser(email: self.Email,
                                                   password: self.Password) { result in
                            switch result {
                            case .success(let user):
                                isHomeScreenView.toggle()
                            case .failure(let error):
                                alertMessage = error.localizedDescription
                                isShowAlert.toggle()
                            }
                        }
                        
                        
                    } else {
                        print("Registration")
                        
                        guard Password == RepeatPassword else {
                            self.alertMessage = "Look Password Again"
                            self.isShowAlert.toggle()
                            return
                        }
                        
                        
                        
                        viewModel.Register(email: self.Email,
                                                  password: self.Password) { result in
                            switch result {
                                
                            case .success(let user):
                                
                                alertMessage = "You registered with \(user.email! )"
                                self.isShowAlert.toggle()
                                self.Email = ""
                                self.Password = ""
                                self.RepeatPassword = ""
                                self.isAuth.toggle()
                                self.viewModel.didAuthenticateUser.toggle()
                                
                            case .failure(let error):
                                alertMessage = "Registration Error \(error.localizedDescription)!"
                                self.isShowAlert.toggle()
                            }
                        }
                        
                        
                        
                       
                    }
                } label: {
                    Text(isAuth ? "Sign In" : "Sign up")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 340, height: 60)
                        .background(Color("LaunchScreenBackground"))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 10, y: 10)

            }
            
            Spacer()
           
            
            Button(action: {
                isAuth.toggle()
            }, label: {
                Text(isAuth ? "Don't have an account ?" : "Already have an account ?")
                    .foregroundColor(Color("LaunchScreenBackground"))
            })
            .padding(.bottom, 32)
            .alert(alertMessage,
                   isPresented: $isShowAlert) {
                Button {  } label: {
                    Text("OK")
                }

            }
        }
        .ignoresSafeArea()
    //        .onAppear {
    //            
    //            DispatchQueue
    //                .main
    //                .asyncAfter(deadline: .now() + 2) {
    //                    launchScreenManager.dismiss()
    //                }
    //        }
        .animation(Animation.easeInOut(duration: 0.6), value: isAuth)
        .fullScreenCover(isPresented: $isHomeScreenView) {
            MainTabView()
        }
        .fullScreenCover(isPresented: $viewModel.didAuthenticateUser) {
            ProfilePhotoSelectorView()
        }
    }
}
