////
////  ContentView.swift
////  deSmet
////
////  Created by Jacob Shushanyan on 19.09.22.
////
//
//import SwiftUI
//
//struct SignView: View {
//
//    @State private var isAuth = true
//    @State private var isHomeScreenView = false
//
//    @State private var email = ""
//    @State private var password = ""
//    @State private var confirmPassword = ""
//    
//    @EnvironmentObject var launchScreenManager: LaunchScreenManager
//    var body: some View {
//
//        VStack(spacing: 24) {
//            Image("NameLogo")
//                .padding(.leading, 24)
//            Text("Discover future with Friends!")
//                .font(.title2)
//
//            VStack(spacing: 12){
//
//                Text(isAuth ? "Create a new account" : "Log in")
//                    .font(isAuth ? .title2 : .largeTitle)
//                    .fontWeight(.bold)
//                    .padding(isAuth ? 16 : 8)
//                    .padding(.horizontal, 40)
//                    .background(.ultraThickMaterial)
//                    .cornerRadius(24)
//                    .padding()
//                VStack {
//                    TextField("Email", text: $email)
//                        .padding()
//                        .background(.ultraThickMaterial)
//                        .cornerRadius(12)
//                        .padding(8)
//                        .padding(.horizontal, 12)
//
//                    SecureField("Password", text: $password)
//                        .padding()
//                        .background(.ultraThickMaterial)
//                        .cornerRadius(12)
//                        .padding(8)
//                        .padding(.horizontal, 12)
//
//                    if isAuth {
//                        SecureField("Confirm Password", text: $confirmPassword)
//                            .padding()
//                            .background(.ultraThickMaterial)
//                            .cornerRadius(12)
//                            .padding(8)
//                            .padding(.horizontal, 12)
//                    }
//                    if isAuth == false {
//                        Button {
//                            print("Forgot Password !")
//                        } label: {
//                            Text("Forgot Password ?")
//                                .font(.caption)
//                                .padding(.trailing, 180)
//                                .padding(.bottom, 12)
//                                .foregroundColor(.black)
//                        }
//
//                    }
//                    Button {
//                        if isAuth {
//                            print("Registration")
//                            isHomeScreenView.toggle()
//                        } else {
//                            print("Authorization")
//                            self.email = ""
//                            self.password = ""
//                            self.confirmPassword = ""
//                            self.isAuth.toggle()
//                        }
//
//
//                    } label: {
//                        Text(isAuth ? "Sign up" : "Sign in")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(.ultraThickMaterial)
//                            .cornerRadius(12)
//                            .padding(8)
//                            .padding(.horizontal, 12)
//                            .font(.title3.bold())
//                            .foregroundColor(.black)
//                    }
//                    Button {
//                        isAuth.toggle()
//                    } label: {
//                        Text(isAuth ? "Already have an account?" : "Don't have an account!")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                        //   .background(.ultraThickMaterial)
//                        //   .cornerRadius(12)
//                        //   .padding(8)
//                            .padding(.horizontal, 8)
//                            .font(.title3)
//                            .foregroundColor(.black)
//                    }
//
//
//                }
//            }
//            .padding(8)
//            .background(.ultraThinMaterial)
//            .cornerRadius(12)
//            .onAppear {
//
//                DispatchQueue
//                    .main
//                    .asyncAfter(deadline: .now() + 4) {
//                        launchScreenManager.dismiss()
//                    }
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .ignoresSafeArea()
//        .background(Color("LaunchScreenBackground"))
//        .animation(Animation.easeInOut(duration: 0.4), value: isAuth)
//        .fullScreenCover(isPresented: $isHomeScreenView) {
//            HeadView()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignView()
//            .environmentObject(LaunchScreenManager())
//    }
//}
