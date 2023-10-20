//
//  ManagerCalendarView.swift
//  backUpMacC
//
//  Created by qwd on 10/14/23.
//

import SwiftUI
import FSCalendar // FSCalendar 패키지를 import

struct CalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.swipeToChooseGesture.isEnabled = true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate {
        var parent: CalendarView

        init(_ parent: CalendarView) {
            self.parent = parent
        }

//        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//            if let date = calendar.currentPage {
//                parent.selectedDate = date
//            }
//        }
    }
}

struct ManagerCalendarView: View {
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            VStack {
                CalendarView(selectedDate: $selectedDate)
                    .frame(height: 300)
                    .position(x:200, y:200)
                
                Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                    .font(.title)
                    .padding(.bottom)
            }
            .navigationBarTitle("다루려쿠")
        }
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

#Preview {
    ManagerCalendarView()
}

//import SwiftUI
//
//struct ManagerCalendarView: View {
//    var body: some View {
//        Text("달력 뷰")
//    }
//}
//
//#Preview {
//    ManagerCalendarView()
//}
