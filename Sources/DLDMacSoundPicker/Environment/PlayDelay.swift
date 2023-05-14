//
//  PlayDelay.swift
//  
//
//  Created by Dionne Lie Sam Foek on 14/05/2023.
//  Copyright © 2023 DiLieDevs. All rights reserved.
//

import SwiftUI

struct PlayDelayEnvironmentKey: EnvironmentKey {
    static var defaultValue: Double = 0.25
}

extension EnvironmentValues {
    var playDelay: Double {
        get { self[PlayDelayEnvironmentKey.self] }
        set { self[PlayDelayEnvironmentKey.self] = newValue }
    }
}

extension View {
    func playDelay(_ delay: Double) -> some View {
        environment(\.playDelay, delay)
    }
}

