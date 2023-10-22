//
//  ImperView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 10/22/23.
//

import SwiftUI

struct ImperView: View {
    @StateObject var mensInfoStore: MensInfoStore = MensInfoStore()
    @State var isHaveMens = false
    @State var mensSympSelected = 0
    @State var mensAmtSelected = 0
    @State var emoLvSelected = 0
    let mensSymp = ["없음", "있음", "아주심함"]
    let mensAmt = ["적음", "보통", "많음"]
    let emoLv = ["보통", "좋음", "나쁨"]
    var body: some View {
        VStack {
            Button(action: {
                isHaveMens.toggle()
            }, label: {
                Image(systemName: "drop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
            })
            if isHaveMens {
                VStack {
                    Text("생리통")
                        .font(.largeTitle)
                    HStack {
                        ForEach(0..<3) { index in
                            Button(action: {
                                self.mensSympSelected = index
                            }, label: {
                                Image(systemName: "drop.circle.fill")
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(self.mensSympSelected == index ? Color.blue : Color.green)
                            })
                        }
                    }
                    Text("생리양")
                        .font(.largeTitle)
                    HStack {
                        ForEach(0..<3) { index in
                            Button(action: {
                                self.mensAmtSelected = index
                            }, label: {
                                Image(systemName: "drop.circle.fill")
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(self.mensAmtSelected == index ? Color.blue : Color.green)
                            })
                        }
                    }
                    Text("감정상태")
                        .font(.largeTitle)
                    HStack {
                        ForEach(0..<3) { index in
                            Button(action: {
                                self.emoLvSelected = index
                            }, label: {
                                Image(systemName: "drop.circle.fill")
                                    .resizable()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(self.emoLvSelected == index ? Color.blue : Color.green)
                            })
                        }
                    }
                    Button(action: {
                        let formatter = ISO8601DateFormatter()
                        mensInfoStore.addNewMensInfo(
                            mensInfo: MensInfo(id: UUID().uuidString, imperID: "abc123"
                                               , mensAmt: mensAmt[mensAmtSelected], mensSymp: mensSymp[mensSympSelected], emoLv: emoLv[emoLvSelected], regDe: formatter.string(from: Date())))
                    }, label: {
                        Text("저장하기")
                    })
                }
            }
        }
    }
}

#Preview {
    ImperView()
}
