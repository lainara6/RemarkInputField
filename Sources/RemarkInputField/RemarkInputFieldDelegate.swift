//
//  RemarkInputFieldDelegate.swift
//  Z1
//
//  Created by Lai Nara on 18/8/22.
//  Copyright © 2022 BlueBee. All rights reserved.
//

public protocol RemarkInputFieldDelegate: AnyObject {
    func remarkInputFieldDidBeginEditing(_ remarkInputField: RemarkInputField)
    func remarkInputFieldDidEndEditing(_ remarkInputField: RemarkInputField)
    func remarkInputFieldDidChange(_ remarkInputField: RemarkInputField, text: String)
}

