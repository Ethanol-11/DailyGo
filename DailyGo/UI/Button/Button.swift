//
//  Button.swift
//  DailyGo
//
//  Created by Danila Petrov on 26.03.2025.
//

import UIKit

public class Button: UIControl {

    // MARK: - Public Properties

    public var style: Button.Style = .defaultStyle {
        didSet {
            applyStyle(for: state)
        }
    }

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

    override public var intrinsicContentSize: CGSize {
        let labelSize = titleLabel.intrinsicContentSize
        return CGSize (
            width: labelSize.width + Constants.defaultInsets.left + Constants.defaultInsets.right,
            height: labelSize.height + Constants.defaultInsets.top + Constants.defaultInsets.bottom
        )
    }


    // MARK: - Constructors

    public init(style: Button.Style) {
        super.init(frame: .zero)

        self.style = style
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

private extension Button {

    enum Constants {
        static let higlightAlpha: CGFloat = 0.8
        static let defaultAlpha: CGFloat = 1.0

        static let defaultInsets = UIEdgeInsets(top: 13.0, left: 26.0, bottom: 13.0, right: 26.0)
    }
}

// MARK: - Private Methods

private extension Button {

    func setupViews() {
        addSubview(titleLabel)

        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1

        addAction(UIAction { [weak self] _ in self?.handleTap() }, for: .touchUpInside)

        applyStyle(for: state)

        self.layer.masksToBounds = true
        self.layer.cornerRadius = (titleLabel.font.pointSize + Constants.defaultInsets.bottom + Constants.defaultInsets.top) / 2.0
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

    func applyStyle(for state: UIControl.State) {
        backgroundColor = style.backgroundColor
        titleLabel.font = style.textFont
    }

    func handleTap() {
        onTap?()
    }
}

