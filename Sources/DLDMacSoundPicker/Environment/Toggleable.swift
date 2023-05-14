//
//  Toggleable.swift
//  
//
//  Created by Dionne Lie Sam Foek on 14/05/2023.
//  Copyright © 2023 DiLieDevs. All rights reserved.
//

import SwiftUI

struct ToggleableEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var toggleable: Bool {
        get { self[ToggleableEnvironmentKey.self] }
        set { self[ToggleableEnvironmentKey.self] = newValue }
    }
}

extension View {
    func toggleable(_ toggleable: Bool = true) -> some View {
        environment(\.toggleable, toggleable)
    }
}
