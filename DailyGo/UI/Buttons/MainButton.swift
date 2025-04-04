//
//  Button.swift
//  DailyGo
//
//  Created by Danila Petrov on 26.03.2025.
//

import UIKit

public class MainButton: UIControl {

    // MARK: - Public Properties

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public var insets: UIEdgeInsets = Constants.defaultInsets {
        didSet {
            setupConstraints()
        }
    }

    override public var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? Constants.higlightAlpha : Constants.defaultAlpha
        }
    }

    public var onTap: (() -> Void)?

    override public var isEnabled: Bool {
        didSet {
            applyColor(for: state)
        }
    }

    override public var intrinsicContentSize: CGSize {
        let labelSize = titleLabel.intrinsicContentSize
        return CGSize (
            width: labelSize.width + Constants.defaultInsets.left + Constants.defaultInsets.right,
            height: labelSize.height + Constants.defaultInsets.top + Constants.defaultInsets.bottom
        )
    }


    // MARK: - Constructors

    public init() {
        super.init(frame: .zero)

        setupViews()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
        setupConstraints()
    }

    // MARK: - Private Properties

    private let titleLabel = UILabel()
}

// MARK: - Private Nested Types

private extension MainButton {

    enum Constants {
        static let higlightAlpha: CGFloat = 0.8
        static let defaultAlpha: CGFloat = 1.0

        static let defaultInsets = UIEdgeInsets(top: 13.0, left: 26.0, bottom: 13.0, right: 26.0)
    }
}

// MARK: - Private Methods

private extension MainButton {

    func setupViews() {
        addSubview(titleLabel)

        titleLabel.font = Fonts.anonymousPro_24
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1

        addAction(UIAction { [weak self] _ in self?.handleTap() }, for: .touchUpInside)

        self.layer.masksToBounds = true
        self.layer.cornerRadius = (titleLabel.font.pointSize + Constants.defaultInsets.bottom + Constants.defaultInsets.top) / 2.0

        applyColor(for: state)
    }

    func setupConstraints() {
        titleLabel.removeConstraints(titleLabel.constraints)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        ])
    }

    func applyColor(for state: UIControl.State) {
        backgroundColor = isEnabled ? Colors.lavenderBlue : .gray
    }

    func handleTap() {
        onTap?()
    }
}

