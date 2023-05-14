//
//  FixedSize.swift
//  
//
//  Created by Dionne Lie Sam Foek on 14/05/2023.
//  Copyright © 2023 DiLieDevs. All rights reserved.
//

import SwiftUI

public struct FixedSizeEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

extension EnvironmentValues {
    public var fixedSize: Bool {
        get { self[FixedSizeEnvironmentKey.self] }
        set { self[FixedSizeEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func applyFixedSize(_ fixed: Bool = true) -> some View {
        environment(\.fixedSize, fixed)
    }
}
