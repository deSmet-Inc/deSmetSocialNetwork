import SwiftUI


struct SideBarView: View {
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 32) {
            VStack(alignment: .trailing) {
                Circle()
                    .frame(width: 64, height: 64)
             
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Jacob")
                        .font(.headline)
                    
                    Text("@Jacobsiks")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                UserStatsView()
                    .padding(.vertical, 4)
            }
            .padding(.trailing)
            
            ForEach(SideMenuViewModel.allCases, id: \.rawValue) { option in
                HStack(spacing: 16){
                    Spacer()
                    
                    Text(option.title)
                        .font(.subheadline)
                    
                    Image(systemName: option.imageName)
                        .font(.headline)
                }
                .frame(height: 48)
                .padding(.trailing)
            }
            Spacer()
        }
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
    }
}



































////
////  SideBarView.swift
////  deSmet
////
////  Created by Jacob Shushanyan on 09.10.22.
////
//
//import SwiftUI
//
//struct SideBarView: View {
//    @State var selectedSideBar = "Home"
//    
////    @State var showMenu = false
//    
//    @Binding var isSideBarShow : Bool
//    
//    @Namespace var animation
//    
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            
//            
//            Color("LaunchScreenBackground")
//                .ignoresSafeArea()
//            
//                Button {
//                    withAnimation(.spring()){
//                        isSideBarShow.toggle()
//                    }
//                } label: {
//                    Image(systemName: "xmark")
//                        .frame(width: 40, height: 45 )
//                        .foregroundColor(.white)
//                        .padding()
//                }
//            
//
//            VStack(alignment: .trailing, spacing: 15, content: {
//                // Profile Photo
//                Image("Profile")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 80, height: 90)
//                    .cornerRadius(10)
//                    .padding(.top, 50)
//                
//                VStack(alignment: .trailing, spacing: 5, content: {
//                    // Profile Name
//                    Text("Jacob")
//                        .font(.title2)
//                        .fontWeight(.heavy)
//                    
//                    Button { } label: {
//                        Text("Profile")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.black)
//                            .opacity(0.7)
//                    }
//                })
//                
//                VStack(alignment: .trailing, spacing: 0) {
//                    
//                    SideBarButton(image: "house", title: "Home", selectedSideBar: $selectedSideBar, animation: animation)
//                    
//                    SideBarButton(image: "clock.arrow.circlepath", title: "History", selectedSideBar: $selectedSideBar, animation: animation)
//                    
//                    SideBarButton(image: "bell.badge", title: "Notifications", selectedSideBar: $selectedSideBar, animation: animation)
//                    
//                    SideBarButton(image: "gearshape.fill", title: "Settings", selectedSideBar: $selectedSideBar, animation: animation)
//                    
//                    SideBarButton(image: "questionmark.circle", title: "Help", selectedSideBar: $selectedSideBar, animation: animation)
//                    
//                }
//                .padding(.trailing, -15)
//                .padding(.top, 32)
//                
//                Spacer()
//                
//                SideBarButton(image: "rectangle.lefthalf.inset.fill.arrow.left", title: "Log out", selectedSideBar: $selectedSideBar, animation: animation)
//                    .padding(.trailing, -15)
//                
//                Text("App Version 0.1.5")
//                    .fontWeight(.semibold)
//                    .font(.caption2)
//                    .opacity(0.7)
//                    .foregroundColor(.white)
//                
//            })
//            .padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
//                        
//        }
//    }
//}
//
//struct SideBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBarView(isSideBarShow: .constant(true))
//    }
//}
//    
//extension View {
//        
//        func getRect() -> CGRect {
//            
//            return UIScreen.main.bounds
//    }
//}
