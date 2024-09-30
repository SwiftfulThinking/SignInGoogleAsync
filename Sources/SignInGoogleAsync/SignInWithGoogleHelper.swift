import Foundation
import SwiftUI
import UIKit
@preconcurrency import GoogleSignIn

public final class SignInWithGoogleHelper {
    
    public init(GIDClientID: String) {
        let config = GIDConfiguration(clientID: GIDClientID)
        GIDSignIn.sharedInstance.configuration = config
    }
        
    @MainActor
    public func signIn(viewController: UIViewController? = nil) async throws -> GoogleSignInResult {
        guard let topViewController = viewController ?? UIApplication.topViewController() else {
            throw GoogleSignInError.noViewController
        }
                
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let result = GoogleSignInResult(result: gidSignInResult) else {
            throw GoogleSignInError.badResponse
        }
        
        return result
    }
    
    private enum GoogleSignInError: LocalizedError {
        case noViewController
        case badResponse
        
        var errorDescription: String? {
            switch self {
            case .noViewController:
                return "Could not find top view controller."
            case .badResponse:
                return "Google Sign In had a bad response."
            }
        }
    }
}
