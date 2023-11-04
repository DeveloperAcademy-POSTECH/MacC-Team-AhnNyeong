//
//  CalendarView.swift
//  AhnNyeong
//
//  Created by OhSuhyun on 2023.11.04.
//

import SwiftUI

struct CalendarView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CalendarViewController

    func makeUIViewController(context: Context) -> CalendarViewController {
        return CalendarViewController()
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
        // 업데이트가 필요한 경우 여기에 코드를 추가합니다.
    }
}

#Preview("CalendarView") {
    CalendarView()
}
