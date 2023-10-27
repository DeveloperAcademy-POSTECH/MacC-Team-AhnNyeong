//
//  ImperGreetingView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 10/26/23.
//

import SwiftUI

struct ImperGreetingView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("안녕하세요!")
                    .font(.system(size: 35))
                HStack(alignment: .firstTextBaseline) {
                    Text("이김생리")
                        .font(.system(size: 35, weight: .semibold))
                    Text("님")
                        .font(.system(size: 25))
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 45, bottom: 42, trailing: 0))
            
            Text("시작을 위한 멘트")
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(.gray)
                .padding(.bottom, 50)
            Button(action: {
                
            }, label: {
                Image("pad")
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 8))
            })
            ZStack {
                Image("hand")
                    .offset(x:48, y:-420)
                Image("clickHand")
                    .offset(x:78, y:-40)
            }
            
            Text("시작을 위한 멘트")
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ImperGreetingView()
}
