//
//  SampleAdminCalModalView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 11/5/23.
//

import SwiftUI

struct SampleAdminCalModalView: View {
    @State private var isShowingSheetToday = false
    @State private var isShowingSheetNext = false
    var body: some View {
        VStack {
            Button(action: {
                isShowingSheetToday.toggle()
            }, label: {
                Image("DropFill")
            })
            .sheet(isPresented: $isShowingSheetToday, content: {
                NavigationStack {
                    VStack {
                        TodayMensInfoView(title: "해당일 생리 중")
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                //
                            }, label: {
                                BackButton(backBtnTitleType: .titleText, backButtonTitle: "달력")
                            })
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("2023년 10월 16일(화)")
                    .background(Color.white300)
                }
            })
            .padding(50)
            Button(action: {
                isShowingSheetNext.toggle()
            }, label: {
                Image("Drop")
            })
            .sheet(isPresented: $isShowingSheetNext, content: {
                NavigationStack {
                    VStack {
                        NextMensInfoView(title: "해당일 생리 예정")
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                //
                            }, label: {
                                BackButton(backBtnTitleType: .titleText, backButtonTitle: "달력")
                            })
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("2023년 10월 16일(화)")
                    .background(Color.white300)
                }
            })
        }
    }
}

#Preview {
    SampleAdminCalModalView()
}
