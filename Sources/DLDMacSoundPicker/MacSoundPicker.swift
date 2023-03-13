//
//  MacSoundPicker.swift
//  
//
//  Created by Dionne Lie Sam Foek  on 19/02/2023.
//

import SwiftUI

public struct MacSoundPicker: View {
    public let allSounds: [MacSound]
    public let title: String
    public let playDelay: Double
    @Binding public var selectedSound: MacSound?
    @State private var hoveredSound: MacSound?
    
    public init(_ title: String, selection: Binding<MacSound?>, playDelay: Double = 0.25) {
        let allSounds = MacSound.allSounds()
        self.allSounds = allSounds
        self.title = title
        self._selectedSound = selection
        self.playDelay = playDelay
    }
    
    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            
            Picker(title, selection: $selectedSound) {
                ForEach(allSounds) { sound in
                    SoundItem(for: sound, playDelay: playDelay)
                }
            }
            .labelsHidden()
            .fixedSize()
            .pickerStyle(.menu)
            .onChange(of: selectedSound, perform: { newSound in
                newSound?.play()
            })
            
            Button(action: playSelectedSound) {
                Label("Play Sound", systemImage: "play.circle")
            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .imageScale(.large)
            .help("Play Sound")
            .disabled(selectedSound == nil)
        }
    }
    
    private func playSelectedSound() {
        selectedSound?.play()
    }
}
