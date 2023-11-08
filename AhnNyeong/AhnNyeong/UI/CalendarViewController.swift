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
    let coral500 = UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1) // coral500
    let black500 = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1) // black500
    let black75 = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1)    // black75
    let white50 = UIColor(red: 255/255, green: 255/255, blue: 254/255, alpha: 1)    // white50
    let calmint = UIColor(red: 32/255, green: 211/255, blue: 211/255, alpha: 1) // cal_weekend
    let calyellow = UIColor(red: 255/255, green: 236/255, blue: 165/255, alpha: 1)  // cal_today

    var eventsArray = [Date]()  // 이벤트(예정) <- firebase에서 가져온 또는 예정일 배열
    var eventsArrayDone = [Date]()  // 이벤트(완료) <- firebase에서 가져온 생리 기록 존재일 배열

    var isWeekly = true

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

    let dayOnlyFormatter = DateFormatter().then {
        $0.dateFormat = "d일"
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
        $0.setTitle(isWeekly == false ? "월" : "주", for: .normal)
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
//        configureUI()
        calendarView.reloadData()
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
        cell.eventIndicator.transform = CGAffineTransform(scaleX: 0, y: 0)

        // 오늘 일자 타이틀 색상 지정  // not completed -> HARD coding
        let day = Calendar.current.component(.weekday, from: date) - 1
        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            calendarView.appearance.titleTodayColor = coral500
        } else if Calendar.current.shortWeekdaySymbols[day] == "토" {
            calendarView.appearance.titleTodayColor = calmint
        } else {
            calendarView.appearance.titleTodayColor = black500
        }

        // 셀 배경색
        let selectedColor = CGColor(red: 255/255, green: 236/255, blue: 165/255, alpha: 1)
        let todayColor = CGColor(red: 255/255, green: 236/255, blue: 165/255, alpha: 0.5)
        if date == calendarView.selectedDate {
            cell.layer.backgroundColor = selectedColor
        } else if date == calendarView.today {
            cell.layer.backgroundColor = todayColor
        } else {
            cell.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = CGColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1)

        // 셀에 image 추가
        var iconName: String {
            if self.eventsArray.contains(date) {
                return "drop"
            } else if self.eventsArrayDone.contains(date) {
                return "drop.fill"
            } else {
                return ""
            }
        }
        /*
        // 대상자 물방울
        let cellImage = UIImage(systemName: iconName)?.resize(newWidth: cell.bounds.width/2).withTintColor(coral500)
        cell.backgroundView = UIImageView(image: cellImage)
        cell.backgroundView?.snp.makeConstraints {
            let imageOffset = 4.0
            $0.left.equalToSuperview().offset(imageOffset)
            $0.bottom.equalTo(cell).offset(-3*imageOffset)  // not completed -> HARD coding
        }
         */

        /**/
        // 관리자용 물방울 & 이벤트 수량 라벨 이미지
        if (self.eventsArray.contains(date) || self.eventsArrayDone.contains(date)) {
//            let cellImageView = UIImageView(image: UIImage(systemName: iconName))
            let cellImageView = UIImageView(image: UIImage(named: "CalDrop"))
            cellImageView.tintColor = coral500
            cellImageView.translatesAutoresizingMaskIntoConstraints = true
            let cellImageLable = UILabel().then { [weak self] in
                guard let self = self else { return }
                $0.font = .systemFont(ofSize: 18, weight: .semibold)
                $0.textColor = date > Date() ? coral500 : white50
                $0.text = "\(date > Date() ? self.eventsArray.filter { $0 == date }.count :  self.eventsArrayDone.filter { $0 == date }.count)"
                }
            cell.contentView.addSubview(cellImageView)
            cellImageView.addSubview(cellImageLable)
            cellImageView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalTo(cell.snp.centerY).offset(12.0) // 숫자 레이블 위치 조정
                $0.width.equalTo(32)
                $0.height.equalTo(43)
//                $0.width.equalTo(cell.bounds.width)
//                $0.height.equalTo(cell.bounds.height)
            }
            cellImageLable.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.center.equalTo(cellImageView.snp.center).offset(4.0) // 숫자 레이블 위치 조정
            }
        } else {
            for subview in cell.contentView.subviews {
                if subview is UIImageView {
                    subview.removeFromSuperview()
                }
            }
        }
        /**/
    }

    // 이벤트 기본 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        return [UIColor.clear]
    }

    // 이벤트 표시 갯수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.eventsArray.contains(date) || self.eventsArrayDone.contains(date) {
            return 1
        } else {
            return 0
        }
    }

//    // DateCell의 이미지
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        // 셀에 addView
//        var iconName: String {
//            if self.eventsArray.contains(date) {
//                return "drop"
//            } else if self.eventsArrayDone.contains(date) {
//                return "drop.fill"
//            } else {
//                return ""
//            }
//        }
//        let cellImage = UIImage(systemName: iconName)?.resize(newWidth: 32).withTintColor(coral500.withAlphaComponent(0.5))
//        return cellImage
//    }

    // 일자 표시 위치
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetFor date: Date) -> CGPoint {
        let titleOffset = -8.0
        return CGPoint(x: titleOffset, y: titleOffset*3)
//        return CGPoint(x: 0, y: 0)
    }
}

// MARK: - Method
extension CalendarViewController {
    private func configureCalendar() {
        configureCalendarBasic()
        configureCalendarUI()
        sampleColoring()

        calendarView.placeholderType = .none

        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
    }

    // MARK: - Calendar Components UI
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

        // MARK: - UI AutoLayout
        calendarView.snp.makeConstraints {  // not completed -> sample
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32.0)
            $0.top.equalTo(calendarButtonStackView.snp.bottom).offset(8.0)
            $0.trailing.leading.equalToSuperview().inset(12.0)
//            $0.height.equalTo(view.bounds.height*3/5)    // 달력 높이
            calendarView.rowHeight = 91
            $0.height.equalTo(calendarView.rowHeight*6 + calendarView.headerHeight)    // 달력 높이
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

    private func configureCalendarBasic() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.select(Date())
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scope = isWeekly == false ? .month : .week // 기본 달력 형태(월간/주간)
        calendarView.adjustsBoundingRectWhenChangingMonths = true
    }

    // MARK: - Calendar UI
    private func configureCalendarUI() {
        // header: yyyy년 mm월, weekday: 요일, title: 일자
        calendarView.appearance.headerTitleColor = .clear
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.selectionColor = .clear
        calendarView.appearance.todayColor = .clear
        calendarView.appearance.separators = FSCalendarSeparators(rawValue: 1)!
        calendarView.weekdayHeight = 24.0
        calendarView.headerHeight = 0.0
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 14.0, weight: .bold)
        calendarView.appearance.titleFont = .systemFont(ofSize: 14.0, weight: .bold)
        calendarView.appearance.weekdayTextColor = black500
        calendarView.appearance.titleDefaultColor = black500
        calendarView.collectionViewLayout.sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)    // cell 여백 조정
        calendarView.appearance.imageOffset = CGPoint(x: 0, y: -10)

        let borderColor = CGColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1)
//        calendarView.calendarWeekdayView.layer.borderWidth = 0.5
//        calendarView.calendarWeekdayView.layer.borderColor = borderColor
        calendarView.daysContainer.layer.borderWidth = 0.5
        calendarView.daysContainer.layer.borderColor = borderColor
//        calendarView.layer.addBorder([.bottom, .left, .right], color: black500, width: 0.5)
        calendarView.layer.borderWidth = 0.5
        calendarView.layer.borderColor = borderColor
    }

    private func sampleColoring() { // sample
//        calendarView.backgroundColor = .lightGray.withAlphaComponent(0.2)
//        calendarView.calendarWeekdayView.backgroundColor = .orange.withAlphaComponent(0.2)
//        calendarView.daysContainer.backgroundColor = .purple.withAlphaComponent(0.2)
    }

    // MARK: - goto Prev/Next
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
            self.calendarView.setScope(.week, animated: false)
            self.headerDateFormatter.dateFormat = "YYYY년 MM월 W주차"
            self.headerLabel.text = headerDateFormatter.string(from: calendarView.currentPage)
            self.toggleButton.setTitle("주", for: .normal)
            self.toggleButton.setImage(Icon.downIcon, for: .normal)
        } else {
            self.calendarView.setScope(.month, animated: false)
            self.headerDateFormatter.dateFormat = "YYYY년 MM월"
            self.headerLabel.text = headerDateFormatter.string(from: calendarView.currentPage)
            self.toggleButton.setTitle("월", for: .normal)
            self.toggleButton.setImage(Icon.upIcon, for: .normal)
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

/*
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

extension CALayer {
    func addBorder(_ arrEdge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arrEdge {
            let border = CALayer()
            switch edge {
                case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:

                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}
*/

#Preview("CalendarView") {
    AdminCalView()
}
