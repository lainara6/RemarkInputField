//
//  RemarkInputFieldDelegate.swift
//  Z1
//
//  Created by Lai Nara on 18/8/22.
//  Copyright © 2022 BlueBee. All rights reserved.
//

public protocol RemarkInputFieldDelegate: AnyObject {
    func remarkInputFieldDidBeginEditing(_ remarkInputTextView: RemarkInputField)
    func remarkInputFieldDidEndEditing(_ remarkInputTextView: RemarkInputField)
    func remarkInputFieldDidChange(_ remarkInputTextView: RemarkInputField, text: String)
}

