//
//  GlobalManager.swift
//  Global
//
//  Created by Hetal Patel on 04/12/20.
//

import UIKit
import KRProgressHUD
import AVFoundation



typealias ActionHandlerButton = ((UIButton) -> ())

let RegexNumericLimit        = "^.{3,10}$"
let RegexAlphaNumeric        = "[A-Za-z0-9]{3,10}"
let RegexEmail               = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let RegexRequireAlphaNumeric = "[A-Za-z0-9]{6,20}"
let RegexPhone               = "[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"



//MARK:- Declare Extension
extension UIViewController
{
    func showAlert(title : String , message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.AlertOk, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func checkRegxValidation(regex : String,textfieldValue : String)-> Bool
    {
        let regex = try? NSRegularExpression(pattern: regex, options: NSRegularExpression.Options())
        let match = regex?.firstMatch(in: textfieldValue, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, textfieldValue.count))
        let exist = (match != nil)
        return exist
    }
}
extension String {
    //MARK:-
    
    var trim : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var IsEmpty : Bool {
        return (self.count <= 0)
    }
    
    /*var isValidEmail : Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", RegexEmail)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    var isValidPhone : Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", RegexPhone)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }*/ //Uncomment if you want the statis validation for email and phone
    
    var containSpecialCharacter : Bool {
        let regex = try? NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        let match = regex?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, self.count))
        let exist = (match != nil)
        return exist
    }
    
    //MARK:-
    
    func lengthMax(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthMin(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthEqual(Length length:Int) -> Bool {
        let isValid = (self.count == length)
        return isValid
    }
    
    func hintAttributeString(Attributes dictAttribute: [NSAttributedString.Key : Any]? = nil) -> NSMutableAttributedString? {
        let dictAttribute = [NSAttributedString.Key.foregroundColor:UIColor.darkGray,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0) ]
        var attrStr = NSMutableAttributedString.init(string: self, attributes: dictAttribute)
        
        attrStr =  NSMutableAttributedString.init(string: self)
        let range = NSMakeRange(0, (attrStr.string.count))
        attrStr.addAttributes(dictAttribute, range: range)
        attrStr.addAttributes(dictAttribute, range: ((attrStr.string as NSString?)?.range(of: attrStr.string))!)
        
        return attrStr
        
    }
}
