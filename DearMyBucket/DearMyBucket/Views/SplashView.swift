//
//  SplashView.swift
//  DearMyBucket
//
//  Created by 최진선 on 5/7/25.
//

import SwiftUI

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewDevice("iPhone 16")
            .previewLayout(.sizeThatFits) 
    }
}

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        Group {
            if isActive {
                MainView()
            } else {
                VStack {
                    Text("🐠")
                        .font(.system(size: 80))
                        .padding(.bottom, 10)
                    Text("Dear my bucket")
                        .font(.largeTitle)
                        .foregroundColor(Color("MainBrown")) 
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
