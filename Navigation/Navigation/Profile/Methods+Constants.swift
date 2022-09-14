//
//  Methods+Constants.swift
//  Navigation
//
//  Created by Андрей Абрамов on 28/5/22.
//

import UIKit

public let myLogin = "kenobi"
public let myPass = "qwerty"
public var statusEntry = true

func placeHolder(_ textField: UITextField) -> String {
    switch textField.tag {
    case 1: return "Login"
    case 2: return "Password"
    case 3: return "Type new status"
    default: return "Type something..."
    }
}
    
public func checkInputedData(_ textField: UITextField, _ alert: UILabel) {
    var minLengthFrom = 0
    var minLengthTo = 0
    var message = ""
    switch textField.tag {
    case 1: minLengthFrom = 1
            minLengthTo = 3
            message = "Login must be at least 3 chars"
        //print(message)
    case 2: minLengthFrom = 1
            minLengthTo = 6
            message = "Password must be at least 6 chars"
        //print(message)
    case 3: minLengthFrom = 1000
            minLengthTo = 1000
    default: print("status textField ???")
    }
    
    if let count = textField.text?.count {
        print(count, terminator: " : ")
        switch count {
        case 0:                             shakeMeBaby(textField)
                                            changeTextFieldColorAndText(textField, "Input someting...")
                                            print("statusBEFORE = \(statusEntry)", terminator: " : ")
                                            checkStatus(false)
                                            print("count = \(count), status = \(statusEntry)")
        case minLengthFrom..<minLengthTo:   if textField.tag == 3 {
                                                print("Алерт для строки статуса не запускаем!")
                                            } else {
                                                shakeMeBaby(textField)
                                                alertMessageOnTextField(alert, message)
                                                print("statusBEFORE = \(statusEntry)", terminator: " : ")
                                                checkStatus(false)
                                                print("count = \(count), status = \(statusEntry)")
                                            }
        case minLengthTo...:                print("statusBEFORE = \(statusEntry)", terminator: " : ")
                                            checkStatus(true)
                                            print("count = \(count), status = \(statusEntry)")
        default:                            print("break!!! count = \(count), status = \(statusEntry)")
                                            break
                                        
        }
    }
}

private func changeTextFieldColorAndText(_ textField: UITextField, _ message: String) {
    textField.attributedPlaceholder = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemRed])
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder(textField), attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
    })
}

private func alertMessageOnTextField(_ alert: UILabel, _ message: String) {
    alert.text = message
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
        alert.text = ""
    })
}

private func checkStatus(_ status: Bool) {
    print("(Хмм...........  status = \(statusEntry)) ", terminator:  " : ")
    
    if statusEntry {
        statusEntry = status
    } else {
        statusEntry = false
    }
}

func shakeMeBaby(_ shakedItem: UITextField) {
    let shake = CABasicAnimation(keyPath: "position")
    let xDelta = CGFloat(5)
    shake.duration = 0.15
    shake.repeatCount = 2
    shake.autoreverses = true

    let from_point = CGPoint(x: shakedItem.center.x - xDelta, y: shakedItem.center.y)
    let from_value = NSValue(cgPoint: from_point)

    let to_point = CGPoint(x: shakedItem.center.x + xDelta, y: shakedItem.center.y)
    let to_value = NSValue(cgPoint: to_point)

    shake.fromValue = from_value
    shake.toValue = to_value
    shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    shakedItem.layer.add(shake, forKey: "position")
}
