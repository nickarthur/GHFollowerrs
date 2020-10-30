//
//  ErrorMessage.swift
//  GHFollowerrs
//
//  Created by Larry Nickerson on 10/29/20.
//

import Foundation

private struct LocalizableErrorStrings {
    
    static let invalidUserName = NSLocalizedString("This username created an invalid request. Please try again.",
    comment: "network request failed for username")
    
    static let unableToComplete = NSLocalizedString("Unable to complete your request. Please check your internet connection.", comment: "internet request failed")
    
    static let invalidResponse = NSLocalizedString("Invalid response from the server. Please try again.", comment: "bad response")
    
    static let invalidData = NSLocalizedString("The data received from the server was invalid.  Please try again.",
                                               comment: "Invalid data received")
}

enum GFError: String, Error {
    case invalidUsername
    case unableToComplete
    case invalidResponse
    case invalidData
    
    var localizedString : String {
        get {
                switch(self) {
                case .invalidUsername: return LocalizableErrorStrings.invalidUserName
                case .unableToComplete: return LocalizableErrorStrings.unableToComplete
                case .invalidResponse: return LocalizableErrorStrings.invalidResponse
                case .invalidData: return LocalizableErrorStrings.invalidData
                }
            }
    }
}
