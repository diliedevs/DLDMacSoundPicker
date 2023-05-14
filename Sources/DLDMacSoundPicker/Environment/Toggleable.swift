//
//  Toggleable.swift
//  
//
//  Created by Dionne Lie Sam Foek on 14/05/2023.
//  Copyright © 2023 DiLieDevs. All rights reserved.
//

import SwiftUI

public struct ToggleableEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

extension EnvironmentValues {
    public var toggleable: Bool {
        get { self[ToggleableEnvironmentKey.self] }
        set { self[ToggleableEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func toggleable(_ toggleable: Bool = true) -> some View {
        environment(\.toggleable, toggleable)
    }
}
