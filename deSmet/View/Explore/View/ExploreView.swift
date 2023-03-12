//
//  ExploreView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 28.09.22.
//

import SwiftUI

struct ExploreView: View {
    // header animation
    @State var offsetY: CGFloat = 0
    let themeColor = Color("LaunchScreenBackground")
    var body: some View {
        GeometryReader{proxy in
            let safeAreaTop = proxy.safeAreaInsets.top
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    headerView(safeAreaTop)
                        .offset(y: -offsetY)
                        .zIndex(1)
                    
                    //Scroll content
                    VStack{
                        ForEach(1...10, id: \.self){ _ in
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(themeColor.gradient)
                                .frame(height: 220)
                                
                        }
                    }.padding(15)
                        .zIndex(0)
                }
                .offset(coordinateSpace: .named("SCROLL")){offset in
                    offsetY = offset
                    
                    
                }
            }
            .coordinateSpace(name: "SCROLL")
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    //header
    @ViewBuilder
    func headerView(_ safeAreaTop:CGFloat)->some View{
        let progress = -(offsetY / 80) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 80))
        VStack{
            HStack(spacing:15){
                HStack(spacing:8){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    TextField("Search", text: .constant(""))
                        .tint(.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.black)
                        .opacity(0.15)
                    
                }
                .opacity(1+progress)
                
            }.padding(.bottom, 15)
            HStack(spacing: 15){
                CustomButton(symbolImage: "mic", title: "Listening"){
                    
                }
                CustomButton(symbolImage: "person", title: "Person"){
                    
                }
                CustomButton(symbolImage: "qrcode", title: "QR Code"){
                    
                }
                CustomButton(symbolImage: "qrcode.viewfinder", title: "Scanning"){
                    
                }
                
            }
            
            //moving up navbar
            .padding(.leading, -progress * 58)
            .offset(y: progress * 65)
        }
        //search button
        .overlay(alignment: .topLeading, content: {
            Button{
                
            }label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }.offset(x: 13, y: 10)
        })
        .environment(\.colorScheme, .dark)
        .padding(.top, safeAreaTop * 1.3)
        .padding([.horizontal, .bottom], 15)
        .background{
            Rectangle().fill(themeColor.gradient)
                .padding(.bottom, -progress * 85)
        }

    }
    // buttons
    @ViewBuilder
    func CustomButton(symbolImage: String, title: String, onclick: @escaping()->())->some View{
        let progress = -(offsetY / 40) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 40))

        Button{
            
        }label:{
            VStack(spacing: 8){
                Image(systemName: symbolImage)
                    .fontWeight(.semibold)
                    .foregroundColor(themeColor)
                    .frame(width: 35, height: 35)
                    .background{
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.white)
                    }
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(.white)
                
            }
            .opacity(1 + progress)
            //alternative icons
            .overlay{
                Image(systemName: symbolImage)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(-progress)
                    .offset(y: -9)
            }
        }.padding(.horizontal, 10)
            
    }
    
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}


struct OffSetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

//offset view extension
extension View{
    @ViewBuilder
    func offset(coordinateSpace: CoordinateSpace, completion: @escaping(CGFloat)->())-> some View{
        self
            .overlay{
                GeometryReader{proxy in
                    let minY = proxy.frame(in: coordinateSpace).minY
                    Color.clear
                        .preference(key: OffSetKey.self, value: minY)
                        .onPreferenceChange(OffSetKey.self){ value in
                            completion(value)
                            
                        }
                }
            }
    }
}
