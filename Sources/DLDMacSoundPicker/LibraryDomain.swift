//
//  LibraryDomain.swift
//  
//
//  Created by Dionne Lie Sam Foek  on 20/11/2022.
//

import Foundation
import DLDFoundation

public enum LibraryDomain: Int, CaseIterable, Codable {
    case system, user, local
  
    public var domainMask: FileManager.SearchPathDomainMask {
        switch self {
            case .system : return .systemDomainMask
            case .user   : return .userDomainMask
            case .local  : return .localDomainMask
        }
    }
    
    public var libraries: [URL] {
        Filer.shared.urls(for: .libraryDirectory, in: domainMask)
    }
    
    public var sounds: [MacSound] {
        let soundLibs = libraries.map { $0.appending(path: "Sounds", directoryHint: .isDirectory) }
        let soundsFiles = soundLibs.flatMap(\.contents).map { MacSound(url: $0, domain: self) }
        
        return soundsFiles
    }
}

extension LibraryDomain: Comparable {
    public static func < (lhs: LibraryDomain, rhs: LibraryDomain) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

fileprivate extension URL {
    var contents: [URL] {
        guard hasDirectoryPath, let urls = try? Filer.shared.quickScan(url: self) else { return [] }
        
        return urls
    }
}
