//
//  StorageManager.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

enum FileStorareType: CaseIterable {
    case list
    case live
    
    var fileName: String {
        switch self {
        case .list:
            return "list.json"
        case .live:
            return "live.json"
        }
    }
}

class StorageManager {
    
    
    // MARK: - Public Properties
    
    
    static let shared: StorageManager = StorageManager()
    
    
    // MARK: - Private Methods
    
    
    private func getURL() -> URL {
        if let url: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    
    // MARK: - Public Methods
    
    
    func store<T: Encodable>(_ object: T, fileStorareType: FileStorareType) {
        let url: URL = getURL().appendingPathComponent(fileStorareType.fileName, isDirectory: false)
        
        do {
            let data: Data = try JSONEncoder().encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func retrieve<T: Decodable>(_ fileStorareType: FileStorareType, as type: T.Type) -> T {
        let url: URL = getURL().appendingPathComponent(fileStorareType.fileName, isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File at path \(url.path) does not exist!")
        }
        
        if let data: Data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(url.path)!")
        }
    }
    
    func clearFiles() {
        do {
            for fileStorageType in FileStorareType.allCases {
                let url = getURL().appendingPathComponent(fileStorageType.fileName, isDirectory: false)
                if FileManager.default.fileExists(atPath: url.path) {
                    try FileManager.default.removeItem(at: url)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fileExists(_ fileStorareType: FileStorareType) -> Bool {
        let url = getURL().appendingPathComponent(fileStorareType.fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
}
