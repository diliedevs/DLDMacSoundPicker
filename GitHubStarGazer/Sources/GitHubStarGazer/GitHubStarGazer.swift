//
//  GitHubStarGazer.swift
//  GitHubStarGazer
//
//  Created by Dionne Lie-Sam-Foek on 02/11/2022.
//  Copyright © 2022 DiLieDevs. All rights reserved.
//

import Foundation

public typealias StarGazer = GitHubStarGazer

public struct GitHubStarGazer {
    let username: String
    
    public static func starredRepos(for user: String) async -> [StarredRepo] {
        await GitHubStarGazer(username: user).fetchRepos()
    }
}

private extension GitHubStarGazer {
    func fetchRepos() async -> [StarredRepo] {
        let urlStr = "https://api.github.com/users/\(username)/starred"
        guard let url = URL(string: urlStr) else { return [] }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder(dateDecodingStrategy: .iso8601)
            let repos = try decoder.decode([StarredRepo].self, from: data)
            
            return repos
            
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}

private extension JSONDecoder {
    convenience init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
