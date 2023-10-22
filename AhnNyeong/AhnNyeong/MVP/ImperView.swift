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
    let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    var body: some View {
        
        VStack {
            Button(action: {
                isHaveMens.toggle()
            }, label: {
                Image(systemName: "drop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
            })
            .padding()
            if isHaveMens {
                ScrollView {
                    HStack {
                        Text(dateformat.string(from: Date()))
                            .padding()
                            .font(.title2)
                        Spacer()
                    }
                    .border(.blue)
                    Text("생리통")
                        .font(.largeTitle)
                        .border(.blue)
                    HStack {
                        ForEach(0..<3) { index in
                            Button(action: {
                                self.mensSympSelected = index
                            }, label: {
                                if self.mensSympSelected == index {
                                    Image("mensSymp\(index+1)")
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                } else {
                                    Image("mensSymp\(index+1)_un")
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                }
                                
                            })
                        }
                    }
                    .border(.blue)
                    Text("생리양")
                        .font(.largeTitle)
                        .border(.blue)
                    HStack {
                        ForEach(0..<3) { index in
                            Button(action: {
                                self.mensAmtSelected = index
                            }, label: {
                                if self.mensAmtSelected == index {
                                    Image("mensAmt\(index+1)")
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                } else {
                                    Image("mensAmt\(index+1)_un")
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                }
                            })
                        }
                    }
                    .border(.blue)
                    Text("감정상태")
                        .font(.largeTitle)
                        .border(.blue)
                    HStack {
                        ForEach(0..<3) { index in
                            Button(action: {
                                self.emoLvSelected = index
                            }, label: {
                                if self.emoLvSelected == index {
                                    Image("emoLv\(index+1)")
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                } else {
                                    Image("emoLv\(index+1)_un")
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                }
                            })
                        }
                    }
                    .border(.blue)
                    Button(action: {
                        mensInfoStore.addNewMensInfo(
                            mensInfo: MensInfo(id: UUID().uuidString, imperID: "abc123"
                                               , mensAmt: mensAmt[mensAmtSelected], mensSymp: mensSymp[mensSympSelected], emoLv: emoLv[emoLvSelected], regDe: dateformat.string(from: Date())))
                    }, label: {
                        Rectangle()
                            .cornerRadius(15)
                            .foregroundColor(.secondary)
                            .frame(height: 60)
                            .overlay {
                                Text("저장하기")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                    })
                    .padding()
                    .border(.blue)
                }
            }
        }
    }
}



#Preview {
    ImperView()
}
