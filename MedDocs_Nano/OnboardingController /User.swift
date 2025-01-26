//
//  User.swift
//  task
//
//  Created by TANISHQ on 23/01/25.
//

import Foundation
struct AppUser {
    let email: String
    var password: String
    var name: String?
    
    // Validate email format
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Validate password strength
    static func isValidPassword(_ password: String) -> Bool {
        // At least 8 characters
        return password.count >= 8
    }
}



struct user: Codable {
    let email: String
    let password: String
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
}
