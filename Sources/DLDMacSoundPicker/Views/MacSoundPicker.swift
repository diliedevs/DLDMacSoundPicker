//
//  MacSoundPicker.swift
//  
//
//  Created by Dionne Lie Sam Foek  on 19/02/2023.
//

import SwiftUI
import DLDSwiftUI

public struct MacSoundPicker: View {
    public let title: String
    public let sounds: [MacSound]
    @Binding public var selection: MacSound?
    
    @State private var sound: MacSound?
    @State private var isOn: Bool
    
    @Environment(\.playDelay) private var playDelay
    @Environment(\.fixedSize) private var fixedSize
    @Environment(\.toggleable) private var toggleable
    
    public init(_ title: String, sounds: [MacSound], selection: Binding<MacSound?>) {
        self.title = title
        self.sounds = sounds
        _selection = selection
        _sound = State(wrappedValue: selection.wrappedValue ?? sounds.first)
        _isOn = State(wrappedValue: selection.wrappedValue.isNotNil)
    }
    
    public var body: some View {
        Group {
            if toggleable {
                Toggle(isOn: $isOn) {
                    MainPicker()
                }
                .onChange(of: isOn, perform: processToggle)
            } else {
                MainPicker()
            }
        }
        .onChange(of: sound, perform: updateSound)
    }
}

private extension MacSoundPicker {
    func MainPicker() -> some View {
        HStack {
            Text(title)
            Spacer()

            Picker(title, selection: $sound) {
                ForEach(sounds) { sound in
                    SoundItem(for: sound, playDelay: playDelay)
                        .fullWidth(alignment: .trailing)
                }
            }
            .labelsHidden()
            .disabled(isOn.inverted)
            .if(fixedSize) { $0.fixedSize() }
            .pickerStyle(.menu)

            PlayButton()
        }
    }

    func PlayButton() -> some View {
        Button(action: playSelectedSound) {
            Label("Play Sound", systemImage: "play.circle")
        }
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
        .imageScale(.large)
        .help("Play Sound")
        .disabled(selection.isNil)
    }

    func playSelectedSound() {
        selection?.play()
    }
    
    func updateSound(to newSound: MacSound?) {
        selection = newSound
        playSelectedSound()
    }
    
    func processToggle(to newState: Bool) {
        selection = newState ? sound : nil
    }
}

struct MacSoundPicker_Previews: PreviewProvider {
    struct Container: View {
        var sounds = MacSound.allSounds(in: LibraryDomain.allCases)
        @State private var mySound: MacSound?
        
        init() {
            _mySound = State(wrappedValue: sounds.first)
        }

        var body: some View {
            MacSoundPicker("On success", sounds: sounds, selection: $mySound)
        }
    }

    static var previews: some View {
        VStack(spacing: 20) {
            Container()
                .toggleable()
            
            Container()
                .playDelay(0.05)
                .toggleable()
        }
        .toggleStyle(.checkbox)
        .maxWidth(350)
        .padding()
        .inForm(style: .grouped)
    }
}
