//
//  CalendarViewController.swift
//  AhnNyeong
//
//  Created by OhSuhyun on 2023.11.04.
//

import UIKit
import FSCalendar
import SnapKit
import Then

class CalendarViewController: UIViewController, FSCalendarDelegate {
    let coral500 = UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1)   // coral500
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
    }
    
    // MARK: - Property
    let headerDateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 MM월"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    
    let dayDateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 MM월 dd일"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    
    let standarFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY-MM-dd"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    
    // MARK: - UI
    private lazy var calendarView = FSCalendar(frame: .zero)
    
    private lazy var todayButton = UIButton().then {
        $0.setTitle("오늘", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .semibold)
        $0.backgroundColor = UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1)   // coral500
        $0.contentEdgeInsets = UIEdgeInsets(top: 7.5, left: 9, bottom: 7.5, right: 9)
        $0.layer.cornerRadius = 14.0    // not completed -> HARD coding
        $0.addTarget(self, action: #selector(gotoToday), for: .touchUpInside)
    }
    
    private lazy var toggleButton = UIButton().then {
        $0.setTitle("월", for: .normal)
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
        $0.textColor = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1) // black500
        $0.text = self.headerDateFormatter.string(from: Date())
    }
    
    private lazy var testLabel = UILabel().then {
        $0.text = "today: \(dayDateFormatter.string(from: Date()))" // not completed -> FSCalendar의 오늘이 아닌 실제 기기의 오늘
    }
    
    private lazy var selectedDateLabel = UILabel().then {
        $0.text = "selected: \(calendarView.selectedDate)"
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
    
    // 선택 날짜 반환
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDateLabel.text = "selected: \(dayDateFormatter.string(from: date))"
    }
    
    // 주말 색상 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            return UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1)   // coral500
        } else if Calendar.current.shortWeekdaySymbols[day] == "토" {
            return UIColor(red: 32/255, green: 211/255, blue: 211/255, alpha: 1)   // cal_weekend
        } else {
            return UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1) // black500
        }
    }
}

// MARK: - Method
extension CalendarViewController {
    private func configureUI() {
        // 캘린더 버튼 배치
        let calendarButtonStackView = UIStackView(arrangedSubviews: [
            leftButton,
            headerLabel,
            rightButton
        ]).then {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 12.0
            toggleButton.snp.makeConstraints {
                $0.height.equalTo(28.0)
                $0.width.equalTo(68.0)
            }
        }
        let changeButtonStackView = UIStackView(arrangedSubviews: [
            todayButton,
            toggleButton
        ]).then {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 12.0
            toggleButton.snp.makeConstraints {
                $0.height.equalTo(28.0)
                $0.width.equalTo(68.0)
            }
        }
        [
            calendarView,
            calendarButtonStackView,
            changeButtonStackView,
            testLabel,
            selectedDateLabel
        ].forEach { view.addSubview($0) }
        
        calendarView.snp.makeConstraints {  // not completed -> 
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.leading.equalToSuperview().inset(12.0)
            $0.height.equalTo(view.bounds.height*3/5)    // 달력 높이
        }
        
        calendarButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(calendarView.calendarHeaderView.snp.centerY)
            $0.centerX.equalTo(calendarView.collectionView)
            $0.height.equalTo(28.0)
        }
        
        changeButtonStackView.snp.makeConstraints {
            $0.bottom.equalTo(calendarView.calendarHeaderView.snp.top).offset(-4.0) // sample
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
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.select(Date())
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scope = .month // 기본 달력 형태(월간/주간)
        
        calendarView.appearance.headerTitleColor = .clear
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendarView.appearance.selectionColor = UIColor(red: 255/255, green: 84/255, blue: 61/255, alpha: 1)   // coral500
        
        // header: yyyy년 mm월, weekday: 요일, title: 일자
        calendarView.weekdayHeight = 36.0
        calendarView.headerHeight = 36.0
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 14.0, weight: .bold)
        calendarView.appearance.titleFont = .systemFont(ofSize: 14.0, weight: .bold)
        calendarView.appearance.titleTodayColor = .label
        calendarView.appearance.titleDefaultColor = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1) // black500
        calendarView.appearance.todayColor = UIColor(red: 255/255, green: 236/255, blue: 165/255, alpha: 1) // calToday
        calendarView.appearance.weekdayTextColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 1) // black500
        
        calendarView.placeholderType = .none
        
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
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
    
    // MARK: - Selector
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
        } else {
            self.calendarView.setScope(.month, animated: true)
            self.headerDateFormatter.dateFormat = "YYYY년 MM월"
            self.toggleButton.setTitle("월", for: .normal)
            self.toggleButton.setImage(Icon.upIcon, for: .normal)
            self.headerLabel.text = headerDateFormatter.string(from: calendarView.currentPage)
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
