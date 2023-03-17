//
//  ProfilePicture.swift
//  deSmet
//
//  Created by Apple on 3/13/23.
//

import SwiftUI

struct ProfileComp: View {
    @Environment(\.colorScheme) var colorScheme
    var safeArea: EdgeInsets
    var size: CGSize
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack{
                ProfilePic()
                
                GeometryReader{proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
                    
                    Button {
                        
                    } label: {
                        Text("Follow")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal,48)
                            .padding(.vertical, 12)
                            .background {
                                Capsule()
                                    .fill(Color("LaunchScreenBackground").gradient)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: minY < 50 ? -(minY - 50) : 0)
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)
                
                VStack{
                    // Profile Bio
                    Text("Future star")
                        .fontWeight(.heavy)
                    
                    // content
                    ProfileContent()
                }
                .padding(8)
                .zIndex(0)
            }
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }

    
    @ViewBuilder
    func ProfilePic()-> some View {
        let height = size.height * 0.45
        GeometryReader{proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            Image("Profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY: 0))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom){
                        Rectangle()
                            .fill(
                                colorScheme == .dark ?
                                .linearGradient(colors: [
                                    .black.opacity(0 - progress),
                                    .black.opacity(0.1 - progress),
                                    .black.opacity(0.3 - progress),
                                    .black.opacity(0.5 - progress),
                                    .black.opacity(0.8 - progress),
                                    .black.opacity(1)
                                ], startPoint: .top, endPoint: .bottom) :
                                        .linearGradient(colors: [
                                            .white.opacity(0 - progress),
                                            .white.opacity(0.1 - progress),
                                            .white.opacity(0.3 - progress),
                                            .white.opacity(0.5 - progress),
                                            .white.opacity(0.8 - progress),
                                            .white.opacity(1)
                                        ], startPoint: .top, endPoint: .bottom)
                            )
                        VStack(spacing: 0){
                            Text("Дaрья\nШихaнова")
                                .font(.system(size: 48))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Text("450,243 Montly reaction's".uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding(.top, 16)
                        }
                        .opacity(1 + (progress > 0 ? -progress : progress))
                        .padding(.bottom, 48)
                        
                        .offset(y: minY < 0 ? minY : 0)
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func ProfileContent()-> some View{
        VStack{
            ForEach(1...10, id: \.self){ _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("LaunchScreenBackground").gradient)
                    .frame(height: 220)
                    
            }
        }
    }
    
    @ViewBuilder
    func HeaderView()-> some View{
        GeometryReader {proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height
            
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            .overlay(content: {
                Text("Дaрья Шихaнова")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .fontWeight(.semibold)
                    .offset(y: -titleProgress > 0.7 ? 0 : 45)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0.7)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .background(content: {
                colorScheme == .dark ?
                Color.black
                    .opacity(-progress > 1 ? 1 : 0) :
                Color.white
                    .opacity(-progress > 1 ? 1 : 0)
            })
            .offset(y: -minY)
        }
        .frame(height: 36)
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
