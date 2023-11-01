////
////  ImperView.swift
////  AhnNyeong
////
////  Created by jaelyung kim on 10/22/23.
////
//
//import SwiftUI
//
//struct ImperView: View {
//    @Binding var selectedUserType: ContentView.LoginType
//    @StateObject var mensInfoStore: MensInfoStore = MensInfoStore()
//    @State var isHaveMens = false
//    @State var mensSympSelected = 0
//    @State var mensAmtSelected = 0
//    @State var emoLvSelected = 0
//    let mensSymp = ["없음", "있음", "아주심함"]
//    let mensAmt = ["적음", "보통", "많음"]
//    let emoLv = ["보통", "좋음", "나쁨"]
//    let dateformat: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY년 M월 d일 HH:mm:ss"
//        return formatter
//    }()
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Button(action: {
//                    isHaveMens.toggle()
//                }, label: {
//                    Capsule()
//                        .foregroundColor(isHaveMens ? .pink : .white)
//                        .frame(width: 150, height: 80)
//                        .shadow(radius: 4, x: 2, y: 2)
//                        .overlay(
//                            Image(systemName: "drop.fill")
//                                .font(.system(size: 50, weight: .bold, design: .default))
//                                .foregroundColor(isHaveMens ? .white : .pink)
//                        )
//                })
//                .padding(20)
//                if isHaveMens {
//                    HStack {
//                        ForEach(0..<3) { index in
//                            Button(action: {
//                                self.mensSympSelected = index
//                            }, label: {
//                                if self.mensSympSelected == index {
//                                    Image("mensSymp\(index+1)")
//                                        .frame(width: 100, height: 100)
//                                } else {
//                                    Image("mensSymp\(index+1)_un")
//                                        .frame(width: 100, height: 100)
//                                }
//                            })
//                        }
//                    }
//                    .padding()
//                    HStack {
//                        ForEach(0..<3) { index in
//                            Button(action: {
//                                self.mensAmtSelected = index
//                            }, label: {
//                                if self.mensAmtSelected == index {
//                                    Image("mensAmt\(index+1)")
//                                        .frame(width: 100, height: 100)
//                                } else {
//                                    Image("mensAmt\(index+1)_un")
//                                        .frame(width: 100, height: 100)
//                                }
//                            })
//                        }
//                    }
//                    .padding()
//                    HStack {
//                        ForEach(0..<3) { index in
//                            Button(action: {
//                                self.emoLvSelected = index
//                            }, label: {
//                                if self.emoLvSelected == index {
//                                    Image("emoLv\(index+1)")
//                                        .frame(width: 100, height: 100)
//                                } else {
//                                    Image("emoLv\(index+1)_un")
//                                        .frame(width: 100, height: 100)
//                                }
//                            })
//                        }
//                    }
//                    .padding()
//                    Spacer()
//                    Button(action: {
//                        mensInfoStore.addNewMensInfo(
//                            mensInfo: MensInfo(id: UUID().uuidString, imperID: "abc123", mensAmt: mensAmt[mensAmtSelected],
//                                               mensSymp: mensSymp[mensSympSelected], emoLv: emoLv[emoLvSelected], regDe: dateformat.string(from: Date())))
//                    }, label: {
//                        Rectangle()
//                            .cornerRadius(15)
//                            .frame(height: 60)
//                            .shadow(radius: 4)
//                            .overlay {
//                                Text("저장하기")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                            }
//                    })
//                    .padding()
//                }
//            }
//            Spacer()
//        }
//        .navigationBarTitle("\(Date(), style: .date)")
//        .navigationBarItems(leading:
//            Button(action: {
//                selectedUserType = .notyet
//            }, label: {
//                Image(systemName: "chevron.left")
//            }))
//    }
//}
//
////#Preview {
////    ImperView()
////}
