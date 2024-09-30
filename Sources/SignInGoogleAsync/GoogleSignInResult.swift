import Foundation
import SwiftUI
import UIKit
@preconcurrency import GoogleSignIn

public struct GoogleSignInResult {
    public let idToken: String
    public let accessToken: String
    public let email: String?
    public let firstName: String?
    public let lastName: String?
    public let fullName: String?
    public let profileImageUrl: URL?
    
    public var displayName: String? {
        fullName ?? firstName ?? lastName
    }
    
    init?(result: GIDSignInResult) {
        guard let idToken = result.user.idToken?.tokenString else {
            return nil
        }

        self.idToken = idToken
        self.accessToken = result.user.accessToken.tokenString
        self.email = result.user.profile?.email
        self.firstName = result.user.profile?.givenName
        self.lastName = result.user.profile?.familyName
        self.fullName = result.user.profile?.name
                
        if result.user.profile?.hasImage == true {
            self.profileImageUrl = result.user.profile?.imageURL(withDimension: UInt(400))
        } else {
            self.profileImageUrl = nil
        }
    }
}
