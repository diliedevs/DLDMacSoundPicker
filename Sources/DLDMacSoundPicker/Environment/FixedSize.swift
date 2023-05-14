//
//  FixedSize.swift
//  
//
//  Created by Dionne Lie Sam Foek on 14/05/2023.
//  Copyright © 2023 DiLieDevs. All rights reserved.
//

import SwiftUI

struct FixedSizeEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var fixedSize: Bool {
        get { self[FixedSizeEnvironmentKey.self] }
        set { self[FixedSizeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func applyFixedSize(_ fixed: Bool = true) -> some View {
        environment(\.fixedSize, fixed)
    }
}
