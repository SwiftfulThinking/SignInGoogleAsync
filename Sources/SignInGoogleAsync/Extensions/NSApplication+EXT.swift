//
//  NSApplication+EXT.swift
//  SignInGoogleAsync
//
//  Created by Valentine Zubkov on 30.04.2025.
//

#if os(macOS)

import AppKit

extension NSApplication {
    static func topWindow() -> NSWindow? {
        return NSApplication.shared.windows.first { $0.isKeyWindow } ?? NSApplication.shared.windows.first
    }
}

#endif
