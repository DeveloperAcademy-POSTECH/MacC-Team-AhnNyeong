//
//  CalendarViewController.swift
//  AhnNyeong
//
//  Created by OhSuhyun on 2023.11.04.
//

import SwiftUI
import UIKit
import FSCalendar
import SnapKit
import Then

class CalendarViewController: UIViewController, FSCalendarDelegate {
    let coral500 = UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1)   // coral500
    let black500 = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1) // black500
    let calmint = UIColor(red: 32/255, green: 211/255, blue: 211/255, alpha: 1)   // cal_weekend
    let calyellow = UIColor(red: 255/255, green: 236/255, blue: 165/255, alpha: 1) // calToday

    var eventsArray = [Date]()  // 이벤트(예정)
    var eventsArrayDone = [Date]()  // 이벤트(완료)

    var isTarget = true

    // MARK: - Constant
    struct Icon {
        static let downIcon = UIImage(systemName: "chevron.down")?
            .withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
        static let upIcon = UIImage(systemName: "chevron.up")?
            .withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
        static let leftIcon = UIImage(systemName: "chevron.left")?
            .withTintColor(UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1), renderingMode: .alwaysOriginal)
        static let rightIcon = UIImage(systemName: "chevron.right")?
            .withTintColor(UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1), renderingMode: .alwaysOriginal)
        static let dropIcon = UIImage(systemName: "drop")?
            .withTintColor(UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1), renderingMode: .alwaysOriginal)
        static let dropFillIcon = UIImage(systemName: "drop.fill")?
            .withTintColor(UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1), renderingMode: .alwaysOriginal)
    }

    // MARK: - Property
    let headerDateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 MM월 W주차"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }

    let dayDateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 MM월 dd일"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }

    let standardFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY-MM-dd"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }

    // MARK: - UI components
    private lazy var calendarView = FSCalendar(frame: .zero)

    private lazy var todayButton = UIButton().then {
        $0.setTitle("오늘", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .semibold)
        $0.backgroundColor = coral500
        $0.contentEdgeInsets = UIEdgeInsets(top: 7.5, left: 9, bottom: 7.5, right: 9)
        $0.layer.cornerRadius = 14.0    // not completed -> HARD coding
        $0.addTarget(self, action: #selector(gotoToday), for: .touchUpInside)
    }

    private lazy var toggleButton = UIButton().then {
        $0.setTitle(isTarget == false ? "월" : "주", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0)
        $0.setTitleColor(.label, for: .normal)
        $0.setImage(Icon.downIcon, for: .normal)
        $0.backgroundColor = .systemGray6
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12.0, bottom: 0, right: 0)
        $0.layer.cornerRadius = 4.0
        $0.addTarget(self, action: #selector(tapToggleButton), for: .touchUpInside)
    }

    private lazy var leftButton = UIButton().then {
        $0.setImage(Icon.leftIcon, for: .normal)
        $0.addTarget(self, action: #selector(tapBefore), for: .touchUpInside)
    }

    private lazy var rightButton = UIButton().then {
        $0.setImage(Icon.rightIcon, for: .normal)
        $0.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
    }

    private lazy var headerLabel = UILabel().then { [weak self] in
        guard let self = self else { return }
        $0.font = .systemFont(ofSize: 22, weight: .bold)
        $0.textColor = black500
        $0.text = self.headerDateFormatter.string(from: Date())
    }

    private lazy var testLabel = UILabel().then {
        $0.text = "today: \(dayDateFormatter.string(from: Date()))" // not completed -> FSCalendar의 오늘이 아닌 실제 기기의 오늘
    }

    private lazy var selectedDateLabel = UILabel().then {   // 선택 전 값은 nil이어서 현재 시간을 대신 출력
        $0.text = "selected: \(calendarView.selectedDate ?? Date())"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureCalendar()
    }
}

// MARK: - FSCalendar
extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = calendarView.currentPage
        headerLabel.text = headerDateFormatter.string(from: currentPage)
    }

    // 날짜 선택 시 <- 선택 날짜 반환
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectedDateString = dayDateFormatter.string(from: date)
        selectedDateLabel.text = "selected: \(selectedDateString)"
        if (date>Date()) {    // 예정일
            eventsArray.append(date)
        } else {    // 오늘과 과거
            eventsArrayDone.append(date)
        }

        // 선택 일자 타이틀 색상 지정
        let day = Calendar.current.component(.weekday, from: date) - 1
        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            calendarView.appearance.titleSelectionColor = coral500
        } else if Calendar.current.shortWeekdaySymbols[day] == "토" {
            calendarView.appearance.titleSelectionColor = calmint
        } else {
            calendarView.appearance.titleSelectionColor = black500
        }

//        viewDidLoad()
    }

    // 주말 색상 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let day = Calendar.current.component(.weekday, from: date) - 1

        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            return coral500
        } else if Calendar.current.shortWeekdaySymbols[day] == "토" {
            return calmint
        } else {
            return black500
        }
    }

    // 캘린더 오늘/선택 날짜 표시
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 24/8
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor*1.5)

        // 오늘 일자 타이틀 색상 지정  // not completed -> HARD coding
        let day = Calendar.current.component(.weekday, from: date) - 1
        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            calendarView.appearance.titleTodayColor = coral500
        } else if Calendar.current.shortWeekdaySymbols[day] == "토" {
            calendarView.appearance.titleTodayColor = calmint
        } else {
            calendarView.appearance.titleTodayColor = black500
        }
    }

    // 캘린더 오늘/선택 날짜 표시 위치
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 0)
    }

    // 이벤트 기본 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.eventsArray.contains(date) {
            return [UIColor.yellow]
        }
        if self.eventsArrayDone.contains(date) {
            return [UIColor.purple]
        }
        return nil
    }

    // 이벤트 표시 갯수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if (self.eventsArray.contains(date) || self.eventsArrayDone.contains(date)) {
            return 1
        } else {
            return 0
        }
    }

    // DateCell의 이미지
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        var iconName: String {
            if self.eventsArray.contains(date) {
                return "drop"
            } else if self.eventsArrayDone.contains(date) {
                return "drop.fill"
            } else {
                return "square"
            }
        }
        return UIImage(systemName: iconName)?.resize(newWidth: 24).withTintColor(coral500)
    }

    // 일자 표시 위치
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetFor date: Date) -> CGPoint {
        let titleOffset = -8.0
        return CGPoint(x: titleOffset, y: titleOffset*1.5)
    }

//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        var count = 0
//        if self.eventsArray.contains(date) {
//            count += 1
//            return "\(count)"
//        } else if self.eventsArrayDone.contains(date) {
//            count += 1
//            return "\(count)"
//        } else {
//            return "square"
//        }
//    }
}

// MARK: - Method
extension CalendarViewController {
    private func configureUI() {
        // 캘린더 버튼 배치
        let calendarButtonStackView = UIStackView(arrangedSubviews: [leftButton, headerLabel, rightButton]).then {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 12.0
            toggleButton.snp.makeConstraints {
                $0.height.equalTo(28.0)
                $0.width.equalTo(68.0)
            }
        }
        let changeButtonStackView = UIStackView(arrangedSubviews: [todayButton, toggleButton]).then {   // not completed -> sample
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 12.0
            toggleButton.snp.makeConstraints {
                $0.height.equalTo(28.0)
                $0.width.equalTo(68.0)
            }
        }
        [calendarView, calendarButtonStackView, changeButtonStackView, testLabel, selectedDateLabel].forEach { view.addSubview($0) }

        // UI 레이아웃
        calendarView.snp.makeConstraints {  // not completed -> sample
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32.0)
            $0.top.equalTo(calendarButtonStackView.snp.bottom).offset(8.0)
            $0.trailing.leading.equalToSuperview().inset(12.0)
//            $0.height.equalTo(view.bounds.height*3/5)    // 달력 높이
            $0.height.equalTo(calendarView.rowHeight*8)    // 달력 높이
            print(calendarView.rowHeight)
        }
        calendarButtonStackView.snp.makeConstraints {
//            $0.centerY.equalTo(calendarView.calendarHeaderView.snp.centerY)
            $0.top.equalTo(changeButtonStackView.snp.bottom).offset(4.0)
            $0.centerX.equalTo(calendarView.collectionView)
            $0.height.equalTo(28.0)
        }
        changeButtonStackView.snp.makeConstraints { // not completed -> sample
//            $0.bottom.equalTo(calendarView.calendarHeaderView.snp.top).offset(-4.0)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        testLabel.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
        selectedDateLabel.snp.makeConstraints {
            $0.top.equalTo(testLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
    }

    private func configureCalendar() {
        configureCalendarBasic()
        configureCalendarUI()
        sampleColoring()

        calendarView.placeholderType = .none

        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
    }

    private func configureCalendarBasic() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.select(Date())
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scope = isTarget == false ? .month : .week // 기본 달력 형태(월간/주간)
    }

    private func configureCalendarUI() {
        // header: yyyy년 mm월, weekday: 요일, title: 일자
        calendarView.appearance.headerTitleColor = .clear
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.selectionColor = calyellow
        calendarView.appearance.borderRadius = 0.0
        calendarView.weekdayHeight = 24.0
        calendarView.rowHeight = 64.0
        calendarView.headerHeight = 0.0
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 14.0, weight: .bold)
        calendarView.appearance.titleFont = .systemFont(ofSize: 14.0, weight: .bold)
        calendarView.appearance.titleDefaultColor = black500
        calendarView.appearance.todayColor = calyellow.withAlphaComponent(0.5)
        calendarView.appearance.weekdayTextColor = black500
    }

    private func sampleColoring() { // sample
        calendarView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        calendarView.calendarWeekdayView.backgroundColor = .orange.withAlphaComponent(0.2)
        calendarView.daysContainer.backgroundColor = .purple.withAlphaComponent(0.2)
    }

    func getNextMonth(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to: date)!
    }

    func getNextWeek(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: date)!
    }

    func getPreviousMonth(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }

    func getPreviousWeek(date: Date) -> Date {
        return  Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: date)!
    }

    // MARK: - Selector Method
    @objc func gotoToday() {
        self.calendarView.select(dayDateFormatter.date(from: dayDateFormatter.string(from: Date())), scrollToDate: true)
    }

    @objc func tapToggleButton() {
        if self.calendarView.scope == .month {
            self.calendarView.setScope(.week, animated: true)
            self.headerDateFormatter.dateFormat = "YYYY년 MM월 W주차"
            self.toggleButton.setTitle("주", for: .normal)
            self.toggleButton.setImage(Icon.downIcon, for: .normal)
            self.headerLabel.text = headerDateFormatter.string(from: calendarView.currentPage)
            self.calendarView.rowHeight = 90
        } else {
            self.calendarView.setScope(.month, animated: true)
            self.headerDateFormatter.dateFormat = "YYYY년 MM월"
            self.toggleButton.setTitle("월", for: .normal)
            self.toggleButton.setImage(Icon.upIcon, for: .normal)
            self.headerLabel.text = headerDateFormatter.string(from: calendarView.currentPage)
            self.calendarView.rowHeight = 64
        }
    }

    @objc func tapNext() {
        if self.calendarView.scope == .month {
            self.calendarView.setCurrentPage(getNextMonth(date: calendarView.currentPage), animated: true)
        } else {
            self.calendarView.setCurrentPage(getNextWeek(date: calendarView.currentPage), animated: true)
        }
    }

    @objc func tapBefore() {
        if self.calendarView.scope == .month {
            self.calendarView.setCurrentPage(getPreviousMonth(date: calendarView.currentPage), animated: true)
        } else {
            self.calendarView.setCurrentPage(getPreviousWeek(date: calendarView.currentPage), animated: true)
        }
    }
}

// MARK: - UIImage Extension
extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
}

#Preview("CalendarView") {
    AdminCalView()
}
