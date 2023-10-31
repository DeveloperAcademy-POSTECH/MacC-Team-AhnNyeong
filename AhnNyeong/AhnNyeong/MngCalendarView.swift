//
//  MngCalendarView.swift
//  AhnNyeong
//
//  Created by OhSuhyun on 2023.10.30.
//

import SwiftUI
import FSCalendar

struct MngCalendarView: View {
    @Binding var notiCnt: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                BadgedBell(badgeCnt: notiCnt)
                Spacer()
                Image(systemName: "square")
            }
            .foregroundColor(.gray)
            .font(.system(size: 32))
            .padding(.horizontal, 16)
            /*
            HStack(spacing: 0) {
               Button(action: {
                   CalendarViewController().prevMonthButtonTapped()
               }) {
                   Image(systemName: "chevron.left")
               }
               .frame(width: 24, height: 24, alignment: .leading)
                Text("\(CalendarViewController().currentYear)년 \(CalendarViewController().currentMonth)일")
                   .font(.headline)
               Button(action: {
                   CalendarViewController().nextMonthButtonTapped()
               }) {
                   Image(systemName: "chevron.right")
               }
               .frame(width: 24, height: 24, alignment: .trailing)
           }
           .padding(.top, 28)
             */
            CalendarView()
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}

struct BadgedBell: View {
    var badgeCnt: Int
    
    var body: some View {
        Image(systemName: "bell")
            .overlay {
                Capsule()
                    .fill(badgeCnt == 0 ? .clear : .red)
                    .frame(width: 18 * widthMultplier(), height: 18, alignment: .topTrailing)
                    .overlay {
                        if hasTwoOrLessDigits() {
                            Text("\(badgeCnt)")
                                .foregroundColor(badgeCnt == 0 ? .clear : .white)
                              .font(Font.caption)
                          } else {
                            Text("99+")
                                  .foregroundColor(.white)
                              .font(Font.caption)
                              .frame(width: 15 * widthMultplier(), height: 15, alignment: .center)
                          }
                    }
                    .padding(.bottom, 24)
                    .padding(.leading, 32)
            }
    }
    
    func hasTwoOrLessDigits() -> Bool {
        return badgeCnt < 100
    }
    
    func widthMultplier() -> Double {
        if badgeCnt < 10 {   // 한자리수
          return 1.0
        } else if badgeCnt < 100 {   // 두자리수
          // two digits
          return 1.5
        } else {    // 세자리수 이사
          return 2.0
        }
      }
}

#Preview {
    MngCalendarView(notiCnt: .constant(999))
}
