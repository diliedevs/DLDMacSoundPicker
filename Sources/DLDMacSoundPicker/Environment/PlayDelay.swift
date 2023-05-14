//
//  PlayDelay.swift
//  
//
//  Created by Dionne Lie Sam Foek on 14/05/2023.
//  Copyright © 2023 DiLieDevs. All rights reserved.
//

import SwiftUI

public struct PlayDelayEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Double = 0.25
}

extension EnvironmentValues {
    public var playDelay: Double {
        get { self[PlayDelayEnvironmentKey.self] }
        set { self[PlayDelayEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func playDelay(_ delay: Double) -> some View {
        environment(\.playDelay, delay)
    }
}

