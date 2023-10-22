//
//  ManagerViewForMVP.swift
//  AhnNyeong
//
//  Created by qwd on 10/22/23.
//

import SwiftUI

struct ManagerViewForMVP: View {
    let currentDate = Date()
    let circleTexts = ["1", "2", "3"]
    var body: some View {
        ForEach(0..<6, id: \.self){ _ in
            Spacer()
        }
        VStack(alignment: .leading, content: {
            Text("\(currentDate, style: .date)")
                .font(.title)
                .fontWeight(.semibold)
//            ForEach(mensInfoStore.mensInfos, id: \.self) { mensInfo in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer()
                        Rectangle()
                            .frame(width: 362, height: 120)
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                            .overlay {
                                HStack {
                                    ForEach(0..<3, id: \.self) { index in
                                        Circle()
                                            .foregroundColor(.white)
                                            .frame(width: 100, height: 100)
                                            .overlay(Text(circleTexts[index]))
                                    }
                                }
                            }
                    }
//                }
            }
        })
    }
}

#Preview {
    ManagerViewForMVP()
}
