//
//  MensDetailOfImperView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 10/30/23.
//

import SwiftUI

struct MensDetailOfImperView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            HashtagView(sentence: "도전적 행동 주의")
                            HashtagView(sentence: "과다 월경")
                            HashtagView(sentence: "불규칙한 주기")
                        }
                        .padding(15)
                        HStack {
                            Spacer()
                            Text("개인 증상 태그 및 메모 작성하기")
                            Image(systemName: "pencil")
                        }
                        .padding(.trailing, 12)
                        .padding(.bottom, 20)
                    }
                    .padding(20)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray)
                        .padding(20)
                )
                HStack {
                    Text("마지막 생리일부터")
                    Circle()
                        .foregroundColor(.white)
                        .shadow(radius: 15)
                        .overlay {
                            HStack(spacing: 0) {
                                Text("283")
                                    .font(.system(size: 30, weight: .semibold))
                                Text("일")
                                    .font(.system(size: 15))
                            }
                        }
                        .frame(width: 80, height: 80)
                        .padding()
                    Text("지남")
                }
                MonthlyMensHistoryView()
            }
            .navigationBarTitle(Text("김생리"))
        }
    }
}

struct MonthlyMensHistoryView: View {
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Button(action: {
                        
                    }, label: {
                        Text("연간")
                    })
                    .buttonStyle(YearlyHistoryButton())
                    .offset(x:130, y: -10)
                    .border(.blue)
                    Text("11월")
                        .font(.system(size: 30, weight: .semibold))
                }
            }
            .padding(.top, 20)
            HStack {
                Text("10.31 - 11.07")
                    .font(.system(size: 15))
            }
            .padding(.bottom, 30)
            VStack {
                ForEach(0..<12, id: \.self) { _ in
                    DailyMensHistoryView()
                }
            }
            .padding(.bottom, 27)
        }
        .padding(20)
        .background(
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(.gray)
                .padding(20)
        )
    }
}

struct YearlyHistoryButton: ButtonStyle {
    var labelColor = Color.black
    var backgroundColor = Color(.lightGray)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(labelColor)
            .padding(EdgeInsets(top: 8, leading: 11.5, bottom: 8, trailing: 11.5))
            .background(Rectangle().fill(backgroundColor).cornerRadius(20))
    }
}

struct DailyMensHistoryView: View {
    var body: some View {
        Rectangle()
            .cornerRadius(10)
            .foregroundColor(Color(.lightGray))
            .frame(height: 110)
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            .overlay {
                HStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        Text("11월 7일")
                            .font(.system(size: 15, weight: .semibold))
                        Spacer()
                    }
                    .padding(.top, 7)
                    VStack {
                        Image("mensSymp")
                        Text("많이 아파요")
                            .font(.system(size: 10, weight: .semibold))
                    }
                    VStack {
                        Image("mensAmt")
                        Text("보통이에요")
                            .font(.system(size: 10, weight: .semibold))
                    }
                    VStack {
                        Image("emoLv")
                        Text("나빠요")
                            .font(.system(size: 10, weight: .semibold))
                    }
                }
            }
    }
}

struct HashtagView: View {
    var sentence = "도전적 행동 주의"
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 54)
            .foregroundColor(Color(.lightGray))
            .overlay (
        Text(sentence)
            .padding(.all, 20)
        )
    }
}

#Preview {
    MensDetailOfImperView()
}
