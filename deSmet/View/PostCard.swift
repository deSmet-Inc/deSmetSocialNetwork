//
//  PostCard.swift
//  deSmet
//
//  Created by Иван Ровков on 11.04.2023.
//

import SwiftUI

struct PostCard: View {
  @ObservedObject var postardService = PostCardService()

  @State private var animate = false
  private let duration: Double = 0.3
  private var animationScale: CGFloat {
    postardService.isLiked ? 0.5 : 2.0
  }
  
  init(post: PostModel) {
    self.postardService.post = post
    self.postardService.hasLikedPost()
  }

  var body: some View {
    VStack (alignment: .leading) {
      HStack(spacing: 15) {
        Button(action: {
          self.animate = true
          DispatchQueue.main.asyncAfter(deadline: .now() + self.duration, execute: {
            self.animate = false
            
            if self.postardService.isLiked {
              self.postardService.unlike()
            } else {
              self.postardService.like()
            }
          })
        }) {
          Image(systemName: (self.postardService.isLiked) ? "heart.fill" : "heart")
            .frame(width: 25, height: 25, alignment: .center)
            .foregroundColor((self.postardService.isLiked) ? .red : .black)
        }.padding().scaleEffect(animate ? animationScale : 1)
          .animation(.easeIn(duration: duration))
        
        Image(systemName: "bubble.right")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 25, height: 25, alignment: .center)

        Spacer()
      }.padding(.leading, 16)
      
      if(self.postardService.post.likeCount > 0) {
        Text("\(self.postardService.post.likeCount) likes")
      }
      
      Text("View Comments").font(.caption)
        .padding(.leading)
    }
  }
}

//struct PostCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard()
//    }
//}
