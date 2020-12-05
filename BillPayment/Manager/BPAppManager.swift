//
//  DDAppManager.swift
//  DoctorDirectory
//
//  Created by Hetal Patel on 03/12/20.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation
class BPAppManager : NSObject {
    enum AppStatusType : Int {
        case production
        case staging
        case local
    }

    static let shared = BPAppManager()
    var appStatus : AppStatusType = .local
   
    
//    var user: ARUser?

}
