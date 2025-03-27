//
//  Switch.swift
//  DailyGo
//
//  Created by Danila Petrov on 27.03.2025.
//

import UIKit

public class Switch: UIControl {

    // MARK: - Public Properties

    public var isOn: Bool = false {
        didSet {
            animateToggle()
        }
    }

    public var onSwitch: ((Bool) -> Void)?

    override public var intrinsicContentSize: CGSize {
        return Constants.backgroundSize
    }

    // MARK: - Constructors

    public init(isOn: Bool = false, onSwitch: ((Bool) -> Void)? = nil) {
        super.init(frame: .zero)

        self.isOn = isOn
        self.onSwitch = onSwitch

        setupViews()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
        setupConstraints()
    }

    // MARK: - Public Methods

    override public func layoutSubviews() {
        super.layoutSubviews()

        updateAppearance()
        thumbColorView.frame = thumbBackroundView.bounds
    }

    // MARK: - Private Properties

    private let backgroundView = UIView()
    private let thumbBackroundView = UIView()
    private let thumbColorView = UIView()
}

// MARK: - Private Nested Types

private extension Switch {

    enum Constants {
        static let backgroundSize = CGSize(width: 34.0, height: 14.0)
        static let thumbSize = CGSize(width: 20.0, height: 20.0)

        static let disabledAlpha: CGFloat = 0.4

        static let animationDuration: CGFloat = 0.3

        static let shadowOpacity: Float = 0.5
        static let shadowOffset = CGSize(width: 0.0, height: 1.0)
        static let shadowRadius: CGFloat = 1.0

        static let backgroundOnColor: UIColor = Colors.lavender
        static let backgroundOffColor: UIColor = Colors.ashGray
        static let thumbOnColor: UIColor = Colors.lavenderBlue
        static let thumbOffColor: UIColor = Colors.charcoal
    }
}

// MARK: - Private Methods

private extension Switch {

    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundView.layer.cornerRadius = Constants.backgroundSize.height / 2
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.isUserInteractionEnabled = false

        thumbBackroundView.backgroundColor = .white
        thumbBackroundView.layer.cornerRadius = Constants.thumbSize.height / 2
        thumbBackroundView.translatesAutoresizingMaskIntoConstraints = false
        thumbBackroundView.isUserInteractionEnabled = false

        thumbBackroundView.layer.shadowColor = UIColor.black.cgColor
        thumbBackroundView.layer.shadowOpacity = Constants.shadowOpacity
        thumbBackroundView.layer.shadowOffset = Constants.shadowOffset
        thumbBackroundView.layer.shadowRadius = Constants.shadowRadius

        thumbColorView.layer.cornerRadius = thumbBackroundView.layer.cornerRadius

        addSubview(backgroundView)
        addSubview(thumbBackroundView)
        thumbBackroundView.addSubview(thumbColorView)

        addAction(UIAction { [weak self] _ in self?.toggleState() }, for: .touchUpInside)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.backgroundSize.width),
            heightAnchor.constraint(equalToConstant: Constants.backgroundSize.height),

            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),

            thumbBackroundView.widthAnchor.constraint(equalToConstant: Constants.thumbSize.width),
            thumbBackroundView.heightAnchor.constraint(equalToConstant: Constants.thumbSize.height),
            thumbBackroundView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func updateAppearance() {
        backgroundView.backgroundColor = isOn ? Constants.backgroundOnColor : Constants.backgroundOffColor
        thumbColorView.backgroundColor = isOn ? Constants.thumbOnColor : Constants.thumbOffColor

        let thumbXPosition = isOn ? Constants.backgroundSize.width - Constants.thumbSize.width : 0
        thumbBackroundView.frame.origin.x = thumbXPosition
    }

    func toggleState() {
        isOn.toggle()

        onSwitch?(isOn)
    }

    func animateToggle() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.updateAppearance()
        }
    }
}

