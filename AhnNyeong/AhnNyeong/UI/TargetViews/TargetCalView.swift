//
//  TargetCalView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct TargetCalView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(Color.white50)
                .shadow(color: .black500.opacity(0.15), radius: 3.5, x: 0, y: 2)
                .overlay {
                    VStack(spacing: 0) {
                        TargetCalendarView()  // HARD coding
                            .background {
                                Rectangle()
                                    .cornerRadius(10)
                                    .frame(height: 100)
                                    .foregroundColor(.calWeekday)
                                    .shadow(color: .black500.opacity(0.25), radius: 2, x: 0, y:4)
                                    .overlay {
                                        HStack(spacing: 0) {
                                            Image("SympRecordNone")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            Text("입력된 기록이 없어요")
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundColor(.coral300)
                                                .padding(.leading, 10)
                                        }
                                    }
                            }
                            .frame(height: 541)
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                }
                .frame(height: 560)
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.white300)
    }
}

struct TargetCalendarView: UIViewControllerRepresentable {
    typealias UIViewControllerType = TargetCalViewController

    func makeUIViewController(context: Context) -> TargetCalViewController {
        return TargetCalViewController()
    }

    func updateUIViewController(_ uiViewController: TargetCalViewController, context: Context) {
        // 업데이트가 필요한 경우 여기에 코드를 추가합니다.
    }
}

#Preview {
    TargetCalView()
}
