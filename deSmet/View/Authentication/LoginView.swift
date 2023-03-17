//
//  LoginView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 02.10.22.
//

import SwiftUI

struct LoginView: View {
//    @EnvironmentObject var viewModel: AuthModel

    @State private var isAuth = true
    @State private var isHomeScreenView = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var username: String = ""
    @State private var imageData: Data = Data()
    @State private var showActionSheet = false
    @State private var selectedImage: Image?
    @State private var profileImage: Image?
    @State private var showPhotoPicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var isShowAlert = false
    @State private var alertMessage = "Oh No 😮‍💨"

    func loadImage() {
            guard let inputImage = selectedImage else { return }
            profileImage = inputImage
        }
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            repeatPassword.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty {
            return "Please Fill in all fields and provide a photo"
        }
        return nil
    }
    func signUp() {
        if password != repeatPassword {
            self.error = "Wrong Passwords"
            self.isShowAlert = true
            return
        }
        if let error = errorCheck() {
            self.error = error
            self.isShowAlert = true
            return
        }
        
        AuthService.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: {
            user in
            self.clear()
        }) {
            errorMessage in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.isShowAlert = true
        }
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.isShowAlert = true
            return
        }
    }

    func clear(){
        self.email = ""
        self.password = ""
        self.repeatPassword = ""
        self.username = ""
//        self.profileImage = isemptyView
    }

    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    var body: some View {
        
//        Group {
//
//            // no user logged in
//            if viewModel.userSession == nil {
//                loginInterfaceView
//            } else {
//                MainTabView()
//            }
//
//        }
//
        
            loginInterfaceView
//                .fullScreenCover(isPresented: $showPhotoUploadingView) {
//                    ProfilePhotoSelectorView()
//        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
//            .environmentObject(AuthModel())
    }
}



extension LoginView {
    var loginInterfaceView: some View {
        VStack {

            VStack(alignment: isAuth ? .leading : .trailing) {
                HStack {Spacer()}
                
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
            .frame(height: 240)
            .padding()
            .background(Color("LaunchScreenBackground"))
            .foregroundColor(.white)
            .clipShape(isAuth ? RoundedShape(corners: [.bottomRight]) : RoundedShape(corners: .bottomLeft))
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 15, y: 15)
            
            VStack(spacing: 36){
                
                if isAuth == false {
                    if profileImage != nil {
                        profileImage!.resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                self.showActionSheet = true
                            }
                    } else {
                        Image(systemName: "person.circle.fill").resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                self.showActionSheet = true
                            }
                    }
                }

                
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 SecureFieldisOff: true,
                                 text: $email)
                
                CustomInputField(imageName: "lock",
                                 placeholderText: "Password",
                                 SecureFieldisOff: false,
                                 text: $password)
          
                
                if isAuth == false {
                    CustomInputField(imageName: "lock",
                                     placeholderText: "Repeat Password",
                                     SecureFieldisOff: false,
                                     text: $repeatPassword)
                }
                if isAuth == false {
                    CustomInputField(imageName: "person",
                                     placeholderText: "Username",
                                     SecureFieldisOff: true,
                                     text: $username)
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

                Button(action: isAuth ? signIn : signUp){
                    Text(isAuth ? "Sign In" : "Sign up")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 340, height: 60)
                        .background(Color("LaunchScreenBackground"))
                        .clipShape(Capsule())
                        .padding()
                    
                }.alert(isPresented: $isShowAlert) {
                    Alert(title: Text(alertMessage), message: Text(error), dismissButton: .default(Text("OK")))
                }
//                Button {
//                    if isAuth {
//                        print("Authorization")
//                    } else {
//                        print("Registration")
//                        signUp()
//                    }
//                }label: {
//                    Text(isAuth ? "Sign In" : "Sign up")
//                        .font(.headline)
//                        .bold()
//                        .foregroundColor(.white)
//                        .frame(width: 340, height: 60)
//                        .background(Color("LaunchScreenBackground"))
//                        .clipShape(Capsule())
//                        .padding()
//                }
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
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showPhotoPicker, onDismiss: loadImage){
            ImagePicker(selectedImage: self.$profileImage, imageData: self.$imageData, showPhotoPicker: $showPhotoPicker)
        }.actionSheet(isPresented: $showActionSheet){
            ActionSheet(title: Text("Choose"), buttons: [
                .default(Text("Choose a Photo")){
                    self.sourceType = .photoLibrary
                    self.showPhotoPicker = true
                },
                .default(Text("Take a Photo")){
                    self.sourceType = .camera
                    self.showPhotoPicker = true
                }, .cancel()
                ])
        }
//            .onAppear {
//
//                DispatchQueue
//                    .main
//                    .asyncAfter(deadline: .now() + 2) {
//                        launchScreenManager.dismiss()
//                    }
//            }
        .animation(Animation.easeInOut(duration: 0.6), value: isAuth)
        .fullScreenCover(isPresented: $isHomeScreenView) {
            MainTabView()
        }
//        .fullScreenCover(isPresented: $viewModel.didAuthenticateUser) {
//            ProfilePhotoSelectorView()
//        }
    }
}
