//
//  DDConstant.swift
//  DoctorDirectory
//
//  Created by Hetal Patel on 03/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation
import UIKit

var baseURL : String {
    switch BPAppManager.shared.appStatus {
    case .production:
        return "https://api-staging.bankaks.com/"
    case .staging:
        return "https://api-staging.bankaks.com/"
    case .local:
        return "https://api-staging.bankaks.com/"
    }
}
enum FieldTypes : String {
    case TextfieldType = "textfield"
    case DropdownType = "dropdown"
}
struct Storyboard {
    static let main = "Main"
}
struct Controller {
    static var Detail : BPPaymentDetailController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "BPPaymentDetailController") as? BPPaymentDetailController)!
    }
}
struct CellNib {
    static let FieldsCell       = UINib(nibName: CellIdentifier.FieldsCell, bundle: nil)
}

struct CellIdentifier {
    static let FieldsCell       = "BPFieldsTableCell"
}
struct Strings {
    static let AlertOk = "Ok"
    static let AlertTitle = "Bill Payment"
    static let FailureOperation = "Something went wrong. Please try again later"
    static let Done = "Done"
    static let AlerYES = "Yes"
    static let AlertCancel = "Cancel"
    static let MandatoryFields = "All fields are mandatory"
    static let NotValid = "Please enter valid "


}
struct APIName {
    static var APIFields = baseURL + "task"
    
}
struct Keys {
}

