//
//  RemarkInputField.swift
//  Z1
//
//  Created by Lai Nara on 18/8/22.
//  Copyright © 2022 BlueBee. All rights reserved.
//

import UIKit

open class RemarkInputField: UIStackView {

    public var autocapitalizationType: UITextAutocapitalizationType = .none {
        didSet {
            inputTextView.autocapitalizationType = autocapitalizationType
        }
    }

    public var autocorrectionType: UITextAutocorrectionType = .no {
        didSet {
            inputTextView.autocorrectionType = autocorrectionType
        }
    }

    public var keyboardType: UIKeyboardType = .default {
        didSet {
            inputTextView.keyboardType = keyboardType
        }
    }

    public var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            inputTextView.keyboardAppearance = keyboardAppearance
        }
    }

    public var returnKeyType: UIReturnKeyType = .default {
        didSet {
            inputTextView.keyboardType = keyboardType
        }
    }

    public var delegate: RemarkInputFieldDelegate?

    public var ignoreReturnKey: Bool = true

    public var ignoreScriptInjection: Bool = true

    public var normalBorderColor: UIColor = UIColor(red: 194/255.0, green: 194/255.0, blue: 194/255.0, alpha: 1.0) {
        didSet {
            isActive = isActive ? true : false
        }
    }

    public var activeBorderColor: UIColor = UIColor(red: 48/255.0, green: 128/255.0, blue: 220/255.0, alpha: 1.0) {
        didSet {
            isActive = isActive ? true : false
        }
    }

    public var counterFont: UIFont = UIFont.systemFont(ofSize: 12.0, weight: .regular) {
        didSet {
            counterLabel.font = counterFont
        }
    }

    public var counterColor: UIColor = UIColor(red: 158/255.0, green: 158/255.0, blue: 158/255.0, alpha: 1.0) {
        didSet {
            counterLabel.textColor = counterColor
        }
    }

    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 14.0, weight: .regular) {
        didSet {
            topPlaceholderLabel.font = UIFont(name: placeholderFont.familyName, size: placeholderFont.pointSize - 2)
            centerPlaceholderLabel.font = placeholderFont
        }
    }

    public var placeholderColor: UIColor = UIColor(red: 158/255.0, green: 158/255.0, blue: 158/255.0, alpha: 1.0) {
        didSet {
            topPlaceholderLabel.textColor = placeholderColor
            centerPlaceholderLabel.textColor = placeholderColor
        }
    }

    public var placeholderText: String = "Remark (Optional)" {
        didSet {
            topPlaceholderLabel.text = placeholderText
            centerPlaceholderLabel.text = placeholderText
        }
    }

    public var inputBackgroundColor: UIColor = UIColor.clear {
        didSet {
            backgroundColor = inputBackgroundColor
        }
    }

    public var normalBorderWidth: CGFloat = 1 {
        didSet {
            isActive = isActive ? true : false
        }
    }

    public var activeBorderWidth: CGFloat = 2 {
        didSet {
            isActive = isActive ? true : false
        }
    }

    public var cornerRadius: CGFloat = 6 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    public var font: UIFont = UIFont.systemFont(ofSize: 16.0, weight: .regular) {
        didSet {
            inputTextView.font = font
        }
    }

    public var textColor: UIColor = UIColor(red: 1/255.0, green: 13/255.0, blue: 16/255.0, alpha: 1.0) {
        didSet {
            inputTextView.textColor = textColor
        }
    }

    public var isActive: Bool = false {
        didSet {
            if isActive {
                layer.cornerRadius = cornerRadius
                layer.borderWidth = activeBorderWidth
                layer.borderColor = activeBorderColor.cgColor
                if inputTextView.text.isEmpty {
                    topPlaceholderLabel.alpha = 1
                    centerPlaceholderLabel.alpha = 0
                }
                topConstant = 26
                bottomConstant = 8
            } else {
                layer.cornerRadius = cornerRadius
                layer.borderWidth = normalBorderWidth
                layer.borderColor = normalBorderColor.cgColor
                if inputTextView.text.isEmpty {
                    topPlaceholderLabel.alpha = 0
                    centerPlaceholderLabel.alpha = 1
                    topConstant = 16
                    bottomConstant = 16
                } else {
                    topConstant = 26
                    bottomConstant = 8
                }
            }
        }
    }

    public var topConstant: CGFloat = 0 {
        didSet {
            topConstraint.constant = self.topConstant
        }
    }

    public var bottomConstant: CGFloat = 16 {
        didSet {
            bottomConstraint.constant = -bottomConstant
        }
    }

    public var limitInputCount: Int = 255 {
        didSet {
            counterLabel.text = "\(inputCount)/\(limitInputCount)"
        }
    }
    
    private var contentView: UIView!
    private var stackView: UIStackView!
    private var topPlaceholderLabel: UILabel!
    private var counterLabel: UILabel!
    private var inputTextView: UITextView!
    private var centerPlaceholderLabel: UILabel!
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var inputCount: Int = 0 {
        didSet {
            counterLabel.text = "\(inputCount)/\(limitInputCount)"
        }
    }

    required public init(coder: NSCoder) {
        super.init(coder: coder)
        commitUI()
    }

    private func commitUI() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        clipsToBounds = true
        backgroundColor = inputBackgroundColor

        contentView = UIView()
        contentView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        contentView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        contentView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        addArrangedSubview(contentView)

        inputTextView = UITextView()
        inputTextView.autocapitalizationType = autocapitalizationType
        inputTextView.autocorrectionType = autocorrectionType
        inputTextView.keyboardType = keyboardType
        inputTextView.keyboardAppearance = keyboardAppearance
        inputTextView.returnKeyType = returnKeyType
        inputTextView.delegate = self
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.isScrollEnabled = false
        inputTextView.textContainerInset = UIEdgeInsets(top: 0, left: -inputTextView.textContainer.lineFragmentPadding, bottom: 0, right: -inputTextView.textContainer.lineFragmentPadding)
        inputTextView.font = font
        inputTextView.textColor = textColor
        inputTextView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        inputTextView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        inputTextView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        inputTextView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        contentView.addSubview(inputTextView)

        topConstraint = inputTextView.topAnchor.constraint(equalTo: contentView.topAnchor)
        bottomConstraint = inputTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            inputTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            inputTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])

        centerPlaceholderLabel = UILabel()
        centerPlaceholderLabel.font = placeholderFont
        centerPlaceholderLabel.textColor = placeholderColor
        centerPlaceholderLabel.text = placeholderText
        centerPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        centerPlaceholderLabel.textAlignment = .left
        inputTextView.addSubview(centerPlaceholderLabel)

        NSLayoutConstraint.activate([
            centerPlaceholderLabel.topAnchor.constraint(equalTo: inputTextView.topAnchor),
            centerPlaceholderLabel.rightAnchor.constraint(equalTo: inputTextView.rightAnchor),
            centerPlaceholderLabel.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor),
            centerPlaceholderLabel.leftAnchor.constraint(equalTo: inputTextView.leftAnchor),
        ])

        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 16)
        ])

        topPlaceholderLabel = UILabel()
        topPlaceholderLabel.font = UIFont(name: placeholderFont.familyName, size: placeholderFont.pointSize - 2)
        topPlaceholderLabel.textColor = placeholderColor
        topPlaceholderLabel.text = placeholderText
        topPlaceholderLabel.textAlignment = .left
        stackView.addArrangedSubview(topPlaceholderLabel)

        counterLabel = UILabel()
        counterLabel.textAlignment = .right
        counterLabel.font = counterFont
        counterLabel.textColor = counterColor
        counterLabel.text = "\(inputCount)/\(limitInputCount)"
        stackView.addArrangedSubview(counterLabel)

        isActive = false
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputTextView.becomeFirstResponder()
    }
}

extension RemarkInputField: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        isActive = true
        delegate?.remarkInputFieldDidBeginEditing(self)
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        isActive = false
        delegate?.remarkInputFieldDidEndEditing(self)
    }

    public func textViewDidChange(_ textView: UITextView) {
        inputCount = NSString(string: textView.text).length
        delegate?.remarkInputFieldDidChange(self, text: textView.text)
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if ignoreReturnKey {
            if nil != newText.rangeOfCharacter(from: CharacterSet.newlines) {
                return false
            }
        }
        if ignoreScriptInjection {
            if nil != newText.rangeOfCharacter(from: CharacterSet(charactersIn: "\"<&>'")) {
                return false
            }
        }
        return NSString(string: newText).length < limitInputCount + 1
    }
}
