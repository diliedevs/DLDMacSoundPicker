//
//  SoundItem.swift
//  
//
//  Created by Dionne Lie Sam Foek  on 19/02/2023.
//

import SwiftUI

struct SoundItem: View {
    let sound: MacSound
    let playDelay: Double
    @State private var timeRemaining: Double
    @State private var isHovering = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    init(for sound: MacSound, playDelay: Double) {
        self.sound = sound
        self.playDelay = playDelay
        _timeRemaining = State(wrappedValue: playDelay)
    }
    
    var body: some View {
        Text(sound.name)
            .tag(MacSound?.some(sound))
            .onHover(perform: startCountdown)
            .onReceive(timer) { time in
                if timeRemaining > 0 { timeRemaining -= 0.1 }
                else                 { timeRemaining = 0 }
            }
            .onChange(of: timeRemaining) { time in
                time == 0 ? playSound() : sound.stop()
            }
    }
    
    func startCountdown(onHover hovering: Bool) {
        if hovering { timeRemaining = playDelay }
        else        { sound.stop() }
        
        isHovering = hovering
    }
    
    func playSound() {
        if isHovering { sound.play() }
    }
}

struct SoundItem_Previews: PreviewProvider {
    static var previews: some View {
        SoundItem(for: .first, playDelay: 0.25)
    }
}
