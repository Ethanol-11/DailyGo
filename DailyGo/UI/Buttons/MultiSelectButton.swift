//
//  File.swift
//  DailyGo
//
//  Created by Danila Petrov on 04.04.2025.
//

import UIKit

public class MultiSelectButton: UIControl {

    // MARK: - Public Properties

    public var onTap: ((Bool) -> Void)?

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

    override public var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    override public var isSelected: Bool {
        didSet {
            animateToggle()
        }
    }

    override public var intrinsicContentSize: CGSize {
        let labelSize = titleLabel.intrinsicContentSize
        let checkImageSize = checkImageView.intrinsicContentSize
        let buttonImageSize = buttonImageView.intrinsicContentSize

        return CGSize (
            width: checkImageSize.width + buttonImageSize.width + labelSize.width + Constants.defaultInsets.left + Constants.defaultInsets.right + Constants.textPadding * 2,
            height: buttonImageSize.height + Constants.defaultInsets.top + Constants.defaultInsets.bottom
        )
    }

    // MARK: - Constructors

    public init(buttonImage: UIImage, onTap: ((Bool) -> Void)? = nil) {
        super.init(frame: .zero)
        
        buttonImageView.image = buttonImage
        self.onTap = onTap

        setupViews()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
        setupConstraints()
    }

    // MARK: - Private Properties

    private var checkImageView = UIImageView()
    private var buttonImageView = UIImageView()
    private let titleLabel = UILabel()
}

// MARK: - Private Nested Types

private extension MultiSelectButton {

    enum Constants {
        static let notSelectedAlpha: CGFloat = 0.0

        static let textPadding: CGFloat = 12.0

        static let animationDuration: CGFloat = 0.1

        static let defaultInsets = UIEdgeInsets(top: 8.0, left: 20.0, bottom: 8.0, right: 20.0)

    }
}

// MARK: - Private Methods

private extension MultiSelectButton {

    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.image = Icons.checkCircle_25
        checkImageView.alpha = Constants.notSelectedAlpha

        buttonImageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = Fonts.anonymousPro_16
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1

        addSubview(titleLabel)
        addSubview(checkImageView)
        addSubview(buttonImageView)

        addAction(UIAction { [weak self] _ in self?.toggleSelected() }, for: .touchUpInside)

        self.layer.masksToBounds = true
        self.layer.cornerRadius = (buttonImageView.intrinsicContentSize.height + Constants.defaultInsets.bottom + Constants.defaultInsets.top) / 2.0

        updateAppearance()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
            checkImageView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            checkImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),

            buttonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            buttonImageView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            buttonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)
        ])
    }

    func updateAppearance() {
        backgroundColor = isEnabled ? Colors.skyBlue : .gray
    }

    func toggleSelected() {
        guard isEnabled else { return }

        isSelected.toggle()

        onTap?(isSelected)
    }

    func animateToggle() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.checkImageView.alpha = self.isSelected ? 1.0 : 0.0
            self.backgroundColor = self.isSelected ? Colors.lavender : Colors.skyBlue
        }
    }
}

