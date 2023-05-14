//
//  MacSound.swift
//  
//
//  Created by Dionne Lie Sam Foek  on 20/11/2022.
//

import AppKit
import DLDFoundation

public struct MacSound: Codable, Identifiable, Comparable, Hashable {
    public let url: URL
    public let name: String
    public let domain: LibraryDomain
    
    public var id: String { url.absoluteString }
    public var sound: NSSound? { NSSound(contentsOf: url, byReference: false) }
    
    public static var first: MacSound { allSounds().first! }
    
    public init(url: URL, domain: LibraryDomain) {
        self.url = url
        self.name = url.name
        self.domain = domain
    }
    
    public static func < (lhs: MacSound, rhs: MacSound) -> Bool {
        if lhs.domain == rhs.domain { return lhs.name < rhs.name }
        else {
            return lhs.domain < rhs.domain
        }
    }
    
    public static func allSounds(in domains: [LibraryDomain] = LibraryDomain.allCases) -> [MacSound] {
        domains.flatMap(\.sounds).sorted()
    }
    
    public func play() {
        if sound?.isPlaying == false {
            sound?.play()
        }
    }
    
    public func stop() {
        if sound?.isPlaying == true {
            sound?.stop()
        }
    }
}
