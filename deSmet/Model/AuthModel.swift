//
//  AuthModel.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 06.10.22.
//

import Foundation
import Firebase

class AuthModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    private var tempUserSession: FirebaseAuth.User?
    
    static let shared = AuthModel()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    
     func Register(email: String,
                    password: String,
                    complition: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email,
                               password: password) { result, error in

            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }            
            self.tempUserSession = user
            print("User created account, her user id is: \(result?.user.uid ?? "" )")
            
            
            let data = ["email": email, "password": password, "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
            }
        }
    }
    
    
     func LoginUser(email: String,
                   password: String,
                   complition: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result , error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
                guard let user = result?.user else { return }
                self.userSession = user
                
            
            print("User logged in:: \(result?.user.uid ?? "" )")

        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["ProfileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                }
        }
    }
}

