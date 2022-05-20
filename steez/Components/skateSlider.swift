//
//  skateSlider.swift
//  steez
//
//  Created by Jessica Akemi Meguro on 19/05/22.
//

import SwiftUI

struct skateSlider: View {
    
    @State var goToHome = false
    
    var body: some View {
        
        ZStack {
            
            if goToHome {
                Text("HomeScreen")
                    .foregroundColor(Color.white)
            }
            else {
                OnBoardScreen()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("Success")), perform: { _ in
            withAnimation{self.goToHome = true}
        })
    }
}

struct skateSlider_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            skateSlider()
        }
    }
}

struct OnBoardScreen: View {
    
    @State var maxWidth = UIScreen.main.bounds.width - 100
    @State var offset : CGFloat = 0
    
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color("branco"))
            
            Text("Swipe to Connect")
                .fontWeight(.regular)
                .foregroundColor(Color("cinzaescuro"))
                .padding(.leading,100)
            
                
            HStack {
                
                ZStack (alignment: .leading){
                    
                Rectangle()
                    .fill(Color("cinzaescuro"))
                    .frame(width: calculateWidth() + 115)
                    .cornerRadius(50)
                    
                    VStack (alignment: .leading){
                    Image(systemName: "circle.fill")
                        .resizable()
                           .frame(width: 5, height: 5)
                           .foregroundColor(.white)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                           .frame(width: 5, height: 5)
                           .foregroundColor(.white)
                    }
                    .padding(20)
                }
                
                Spacer(minLength: 0)
            }
            
            HStack {
                
                HStack (alignment: .center, spacing: 40){
                
                VStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                           .frame(width: 5, height: 5)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                           .frame(width: 5, height: 5)
                }
                
                VStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                           .frame(width: 5, height: 5)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                           .frame(width: 5, height: 5)
                }
                }
                
                .foregroundColor(.white)
                .offset(x:5)
                .frame(width: 115, height: 60)
                .background(Color("cinzaescuro"))
                .clipShape(Rectangle())
                .cornerRadius(50)
                .offset(x: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
                
                Spacer()
            }
        }
        .frame(width: maxWidth, height: 60)
    }
    
    func calculateWidth()-> CGFloat {
        let percent = offset / maxWidth
        return percent * maxWidth
        
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width > 0 && offset <= maxWidth - 115 {
            offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        
        withAnimation(Animation.easeOut(duration: 0.3)) {
            if offset > 180 {
                offset = maxWidth - 110
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                }
            }
            else {
                offset = 0
            }
        }
    }
}

struct pontinhosSkate: View {
    
//    @State var goToHome = false
    
    var body: some View {
        
        VStack {
            Image(systemName: "circle.fill")
                .resizable()
                   .frame(width: 5, height: 5)
            
            Image(systemName: "circle.fill")
                .resizable()
                   .frame(width: 5, height: 5)
        }
    }
}


