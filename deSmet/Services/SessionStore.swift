//
//  SessionStorage.swift
//  deSmet
//
//  Created by Иван Ровков on 10.04.2023.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class SessionStore: ObservableObject {
  
  @Published var session: User? { didSet { self.didChange.send(self)}}

  var didChange = PassthroughSubject<SessionStore, Never>()
  var handle: AuthStateDidChangeListenerHandle?
  
  func listen() {
    handle = Auth.auth().addStateDidChangeListener({
      (auth, user) in
      
      if let user = user {
        
        let firestoreUserId = AuthService.getUserID(userID: user.uid)
        firestoreUserId.getDocument {
          (document, error) in
          if let dict = document?.data() {
            guard let decodedUser = try? User.init(fromDictionary: dict) else { return }
            self.session = decodedUser
          }
        }
      } else {
        self.session = nil
      }
    })
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
    } catch {
      
    }
  }
  
  func unbind() {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
  
  deinit {
    unbind()
  }
  
}
