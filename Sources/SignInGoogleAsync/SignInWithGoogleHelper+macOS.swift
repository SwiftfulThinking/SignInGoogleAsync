//
//  SignInWithGoogleHelper+macOS.swift
//  SignInGoogleAsync
//
//  Created by Valentine Zubkov on 30.04.2025.
//

#if os(macOS)

import Foundation
import SwiftUI
import AppKit
@preconcurrency import GoogleSignIn

public final class SignInWithGoogleHelper {
    
    public init(GIDClientID: String) {
        let config = GIDConfiguration(clientID: GIDClientID)
        GIDSignIn.sharedInstance.configuration = config
    }
        
    @MainActor
    public func signIn(viewController: NSViewController? = nil) async throws -> GoogleSignInResult {
        guard let topWindow = viewController?.view.window ?? NSApplication.topWindow() else {
            throw GoogleSignInError.noViewController
        }
                
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topWindow)
        
        guard let result = GoogleSignInResult(result: gidSignInResult) else {
            throw GoogleSignInError.badResponse
        }
        
        return result
    }
    
    private enum GoogleSignInError: LocalizedError {
        case noViewController  // Keep the same name as iOS for consistency
        case badResponse
        
        var errorDescription: String? {
            switch self {
            case .noViewController:
                return "Could not find window to present sign in."
            case .badResponse:
                return "Google Sign In had a bad response."
            }
        }
    }
}

#endif
