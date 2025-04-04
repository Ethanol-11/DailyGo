//
//  SourceOfInformationVC.swift
//  DailyGo
//
//  Created by Danila Petrov on 04.04.2025.
//

import UIKit

final class UserPreferencesVC: ViewController {

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateStep()
    }

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private let continueButton = MainButton()
    private let stackView = UIStackView()
    private var currentStep: Int = 0
}

// MARK: - Private Nested Types

private extension UserPreferencesVC {

    enum Constants {
        static let buttonText: String = "Продолжить"

        struct Option {
            let title: String
            let image: UIImage
        }

        static let steps: [(title: String, options: [Option])] = [
            ("Как вы узнали\nо DailyGo", [
                Option(title: "Instagram", image: Icons.instagram_25),
                Option(title: "Facebook", image: Icons.facebook_25),
                Option(title: "Appstore", image: Icons.appstore_25),
                Option(title: "Tiktok", image: Icons.tikTok_25),
                Option(title: "Другие", image: Icons.otherMessengers_25)
            ]),
            ("Какова ваша\nглавная цель?", [
                Option(title: "Повысить продуктивность", image: Icons.incrProductivity_25),
                Option(title: "Улучшить настроение", image: Icons.improveMood_25),
                Option(title: "Саморефрефлексия и рост", image: Icons.selfReflGrowth_25),
                Option(title: "Формирование привычек ", image: Icons.habitFormation_25),
                Option(title: "Управление временем", image: Icons.timeManagement_25)
            ]),
            ("Для чего вы будете\nиспользовать DailyGo?", [
                Option(title: "Настроение", image: Icons.mood_25),
                Option(title: "Календарь", image: Icons.calendar_25),
                Option(title: "Задачи", image: Icons.tasks_25),
                Option(title: "Дневник", image: Icons.diary_25),
                Option(title: "Список дел", image: Icons.toDoList_25),
                Option(title: "Привычки", image: Icons.habits_25),
                Option(title: "События", image: Icons.events_25)
            ])
        ]

        static let labelNumberOfLines: Int = 0

        static let titleTopPadding: CGFloat = 56.0
        static let titleHorizontalPadding: CGFloat = 35.0

        static let stackTopPadding: CGFloat = 63.0
        static let stackHorizontalPadding: CGFloat = 21.0

        static let continueButtonTopPadding: CGFloat = 72.0
        static let continueButtonHorizontalPadding: CGFloat = 71.0
        static let continueButtonBottomPadding: CGFloat = 97.0
    }
}

// MARK: - Private Methods

private extension UserPreferencesVC {

    func setupUI() {
        view.backgroundColor = Colors.softGray

        titleLabel.numberOfLines = Constants.labelNumberOfLines
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.anonymousPro_24
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.title = Constants.buttonText
        continueButton.onTap = {
            self.nextStep()
        }

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(continueButton)

        setupConstraints()
    }

    func updateStep() {
        let step = Constants.steps[currentStep]
        titleLabel.text = step.title

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for option in step.options {
            let multiSelectButton = MultiSelectButton(buttonImage: option.image)
            multiSelectButton.title = option.title
            stackView.addArrangedSubview(multiSelectButton)
        }
    }

    func nextStep() {
        if currentStep < Constants.steps.count - 1 {
            currentStep += 1
            updateStep()
        } else {
            print("end")
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleHorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleHorizontalPadding),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.stackTopPadding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackHorizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackHorizontalPadding),

            continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.continueButtonTopPadding),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.continueButtonHorizontalPadding),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.continueButtonHorizontalPadding),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.continueButtonBottomPadding)
        ])
    }
}



