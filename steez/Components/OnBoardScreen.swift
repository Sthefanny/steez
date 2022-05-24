//
//  OnBoardScreen.swift
//  steez
//
//  Created by Lucas Yoshio Nakano on 23/05/22.
//

import SwiftUI

struct OnBoardScreen: View {
    @State var maxWidth = UIScreen.main.bounds.width - 70
    @State var offset : CGFloat = 0
    @State var showLeftButton = true
    @State var leftButtonSpacing: CGFloat = 5
    
    func calculateWidth()-> CGFloat {
        let percent = offset / maxWidth
        return percent * maxWidth
        
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width > 0 && offset <= maxWidth - 115 {
            leftButtonSpacing = 30
            showLeftButton = false
            offset = value.translation.width
            if offset > 205 {
                generateFeedback()
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(Animation.easeOut(duration: 0.3)) {
            leftButtonSpacing = 5
            showLeftButton = true
            if offset > 205 {
                offset = maxWidth - 110
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                }
                
                offset = 0
            }
            else {
                offset = 0
            }
        }
    }
    
    func generateFeedback() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color("branco"))
            Text("Deslize para conectar")
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
                    .padding(.leading, 20)
                }
                Spacer(minLength: 0)
            }
            HStack {
                HStack (alignment: .center, spacing: 40){
                    if showLeftButton {
                        VStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 5, height: 5)
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 5, height: 5)
                        }
                    } else {
                        VStack{}
                            .padding(.leading, 20)
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
                .padding(.trailing, leftButtonSpacing)
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
}

struct OnBoardScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardScreen()
    }
}
