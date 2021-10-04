//
//  ErrorMessage.swift
//  GitHub Followers
//
//  Created by Admin on 7/27/21.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username creaated an invalid request"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server is invalid. Try again. "
}
