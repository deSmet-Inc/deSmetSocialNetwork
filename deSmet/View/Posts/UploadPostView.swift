//
//  UploadPostView.swift
//  deSmet
//
//  Created by Иван Ровков on 07.04.2023.
//

import SwiftUI

struct UploadPostView: View {
  
  @State private var postImage: Image?
  @State private var pickedImage: Image?
  @State private var showingActionSheet: Bool = false
  @State private var showingImagePicker: Bool = false
  @State private var imageData: Data = Data()
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  @State private var error: String = ""
  @State private var showingAlert: Bool = false
  @State private var alertTitle: String = "Oh no 🥲"
  @State private var text: String = ""
  @FocusState private var textIsFocused: Bool
  
  func loadImage() {
    guard let inputImage = pickedImage else { return }
    postImage = inputImage
  }
  
  func clear() {
    self.postImage = nil
    self.imageData = Data()
    self.text = ""
  }
  
  func errorCheck() -> String? {
    if text.trimmingCharacters(in: .whitespaces).isEmpty ||
        imageData.isEmpty {
      return "Please add a caption and provide an Image"
    }
    
    return nil
  }
  
  func uploadPost() {
    if let error = errorCheck() {
      self.error = error
      self.showingAlert = true
      self.clear()
      return
    }

    PostService.uploadPost(caption: text, imageData: imageData) {
      self.clear()
    } onError: { errorMessage in
      self.error = errorMessage
      self.showingAlert = true
      return
    }

  }
  
  
  var body: some View {
    ScrollView {
      VStack {
        HStack {
          Text("New post").font(.largeTitle)
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
          
          Button {
            uploadPost()
            textIsFocused = false
          } label: {
            Image(systemName: "arrow.up.circle.fill")
              .font(.system(size: 40))
              .foregroundColor(Color("LaunchScreenBackground"))
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
          }

        }

        
        TextEditor(text: $text)
          .frame(height: 200)
          .padding(5)
          .background(RoundedRectangle(cornerRadius: 10).stroke(Color("LaunchScreenBackground")))
          .focused($textIsFocused)
        
        VStack {
          if postImage != nil {
            Group {
              Text("Attachments:")
                .font(.system(size: 20, weight: .semibold))
              
              postImage?
                .resizable()
                .frame(width: 200, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              
          }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
  //      .padding(.horizontal, 15)
        
        
        Button {
          self.showingActionSheet = true
        } label: {
          Image(systemName: "paperclip.circle")
            .font(.system(size: 40))
            .foregroundColor(Color("LaunchScreenBackground"))
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.top, 15)
        }
        
        Spacer()


  //      Spacer()
      }
      .padding()
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
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}
