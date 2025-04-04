//
//  WelcomeVC.swift
//  DailyGo
//
//  Created by Danila Petrov on 04.04.2025.
//

import UIKit

final class WelcomeVC: ViewController {

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Private Properties

    private let logoImageView = UIImageView(image: Icons.logo)
    private let titleLabel = UILabel()
    private let nextScreenButton = MainButton()
    private let sourceOfInformationVC = UserPreferencesVC()
}

// MARK: - Private Nested Types

private extension WelcomeVC {
    
    enum Constants {
        static let labelText: String = "Welcome to\nDailyGo"
        static let buttonText: String = "Продолжить"

        static let labelNumberOfLines: Int = 0

        static let logoTopPadding: CGFloat = 129.0
        static let logoHorizontalPadding: CGFloat = 74.0

        static let labelTopPadding: CGFloat = 63.0
        static let labelHorizontalPadding: CGFloat = 47.0

        static let buttonTopPadding: CGFloat = 105.0
        static let buttonHorizontalPadding: CGFloat = 71.0
        static let buttonBottomPadding: CGFloat = 97.0
    }
}

// MARK: - Private Methods

private extension WelcomeVC {

    func getAttributedText() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: Constants.labelText)

        let rangeBlack = NSRange(location: 0, length: 10)
        let rangeTurquoise = NSRange(location: 11, length: 7)

        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: rangeBlack)
        attributedString.addAttribute(.foregroundColor, value: Colors.turquoise, range: rangeTurquoise)

        return attributedString
    }

    func setupViews() {
        view.backgroundColor = Colors.softGray

        titleLabel.attributedText = getAttributedText()
        titleLabel.numberOfLines = Constants.labelNumberOfLines
        titleLabel.textAlignment = .center
        titleLabel.font = Fonts.peachCream_48
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        nextScreenButton.translatesAutoresizingMaskIntoConstraints = false
        nextScreenButton.title = Constants.buttonText
        nextScreenButton.onTap = {
            self.navigationController?.pushViewController(self.sourceOfInformationVC, animated: true)
        }

        sourceOfInformationVC.navigationItem.hidesBackButton = true

        view.addSubview(titleLabel)
        view.addSubview(logoImageView)
        view.addSubview(nextScreenButton)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.logoTopPadding),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.logoHorizontalPadding),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.logoHorizontalPadding),

            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.labelTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelHorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.labelHorizontalPadding),

            nextScreenButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.buttonTopPadding),
            nextScreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonHorizontalPadding),
            nextScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonHorizontalPadding),
            nextScreenButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonBottomPadding)
        ])
    }
}
