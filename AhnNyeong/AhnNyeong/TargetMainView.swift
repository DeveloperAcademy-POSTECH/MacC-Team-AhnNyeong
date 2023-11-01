//
//  TargetMainView.swift
//  AhnNyeong
//
//  Created by qwd on 10/30/23.
//

import SwiftUI

struct TargetMainView: View {
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.cyan)
                .frame(width:43)
                .overlay {
                    Image(systemName: "drop")
                        .resizable()
                        .frame(width:18, height: 30)
                }
            Text("나의 생리 기록")
                .fontWeight(.semibold)
                .font(.system(size:30))
        }
        .padding(.trailing, 120)
        RoundedRectangle(cornerSize: CGSize(width:20, height:20))
            .frame(width:339, height: 570)
            .foregroundColor(.gray)
            .overlay {
                VStack(spacing: 50) {
                    Text("10월 25일")
                        .fontWeight(.semibold)
                        .font(.system(size: 30))
                    HStack(spacing: 20) {
                        VStack {
                            Image("mensSymp3_un")
                            Image("mensAmt1_un")
                            Image("emoLv3_un")
                        }
                        VStack(spacing: 100) {
                            Text("배가 많이 아파요")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            Text("생리 양이 적어요")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            Text("기분이 나빠요")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                        }
                    }
                    Button(action: {
                        
                    }, label: {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                            .frame(width: 175, height:52)
                            .foregroundColor(.secondary)
                            .overlay {
                                HStack(spacing: 20) {
                                    Text("고치기")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .font(.system(size: 30))
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 32, height: 30)
                                }
                            }
                            .padding(.leading, 150)
                    })

                }
            }
    }
}

#Preview {
    TargetMainView()
}
