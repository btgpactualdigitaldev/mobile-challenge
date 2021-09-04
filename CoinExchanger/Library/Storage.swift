//
//  Storage.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 05/11/19.
//

import UIKit
import Security

// MARK: Arguments for the keychain queries
private let service = "CoinExchanger"
private let kSecClassValue = NSString(format: kSecClass)
private let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
private let kSecValueDataValue = NSString(format: kSecValueData)
private let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
private let kSecAttrServiceValue = NSString(format: kSecAttrService)
private let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
private let kSecReturnDataValue = NSString(format: kSecReturnData)
private let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

public class Storage: NSObject {
    
    enum Directory {
        // Only documents and other data that is user-generated, or that cannot
        // otherwise be recreated by your application, should be stored in the
        // <Application_Home>/Documents directory and will be automatically backed up by iCloud.
        case documents
        
        // Data that can be downloaded again or regenerated should be stored in the
        // <Application_Home>/Library/Caches directory. Examples of files you should put in
        // the Caches directory include database cache files and downloadable content, such as
        // that used by magazine, newspaper, and map applications.
        case caches
    }
    
    /// Returns URL constructed from specified directory
    class fileprivate func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    // MARK: Save Codable To Disk
    class func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            //fatalError(error.localizedDescription)
            //print(String(describing: error))
            print(error.localizedDescription)
        }
    }
    
    // MARK: Save Image To Disk
    class func storeImage(_ object: UIImage, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        do {
            let data = object.pngData()
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            //fatalError(error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    // MARK: Save Data To UserDefaults
    class func storeDefault<T: Encodable>(_ object: T, as fileName: String) {
        UserDefaults.standard.set(object, forKey: fileName)
    }
    
    // MARK: Save Data To KeyChain
    class func storeKeychain(key: String, data: String) {
        if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {

            // Instantiate a new default keychain query
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue,
                                                                                   service,
                                                                                   key,
                                                                                   dataFromString],
                                                                         forKeys: [kSecClassValue,
                                                                                   kSecAttrServiceValue,
                                                                                   kSecAttrAccountValue,
                                                                                   kSecValueDataValue])

            // Add the new keychain item
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)

            if (status != errSecSuccess) {    // Always check the status
                if (status == errSecDuplicateItem) {
                    updateKeychain(key: key, data: data)
                } else {
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Write failed: \(err)")
                    }
                }
            }
        }
    }
    
    // MARK: Load Codable From Disk
    class func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            //fatalError("File at path \(url.path) does not exist!")
            print("File at path \(url.path) does not exist!")
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                //fatalError(error.localizedDescription)
                print("Failed to decode file: \(fileName)")
                return nil
            }
        } else {
            //fatalError("No data at \(url.path)!")
            print("No data at: \(url.path)")
            return nil
        }
    }
    
    // MARK: Load Image From Disk
    class func retrieveImage(_ fileName: String, from directory: Directory) -> UIImage? {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let image = UIImage(data: data) ?? UIImage()
            return image
        } else {
            return nil
        }
    }
    
    // MARK: Load Data From userDefaults
    class func retrieveDefault(forKey fileName: String) -> Any {
        return UserDefaults.standard.value(forKey: fileName) ?? Data()
    }
    
    /// Remove all files at specified directory
    class func clear(_ directory: Directory) {
        let url = getURL(for: directory)
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url,
                includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            //fatalError(error.localizedDescription)
            print("Failed to remove files at: \(directory)")
        }
    }
    
    // MARK: Load Data From Keychain
    class func retrieveKeychain(key: String) -> String? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue,
                                                                               service,
                                                                               key,
                                                                               kCFBooleanTrue ?? true,
                                                                               kSecMatchLimitOneValue],
                                                                     forKeys: [kSecClassValue,
                                                                               kSecAttrServiceValue,
                                                                               kSecAttrAccountValue,
                                                                               kSecReturnDataValue,
                                                                               kSecMatchLimitValue])
        var dataTypeRef :AnyObject?

        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }

        return contentsOfKeychain
    }
    
    // MARK: Remove Specified File From Specified Directory
    class func remove(_ fileName: String, from directory: Directory) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                //fatalError(error.localizedDescription)
                print("No file at: \(url)")
            }
        }
    }
    
    // MARK: Remove from UserDefaults
    class func removeDefault(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    class func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    // MARK: Update Data From Keychain
    class func updateKeychain(key: String, data: String) {
        if let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {

            // Instantiate a new default keychain query
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue,
                                                                                   service,
                                                                                   key],
                                                                         forKeys: [kSecClassValue,
                                                                                   kSecAttrServiceValue,
                                                                                   kSecAttrAccountValue])

            let status = SecItemUpdate(keychainQuery as CFDictionary,
                                       [kSecValueDataValue:dataFromString] as CFDictionary)

            if (status != errSecSuccess) {
                if let err = SecCopyErrorMessageString(status, nil) {
                    print("Read failed: \(err)")
                }
            }
        }
    }
    
    // MARK: Remove Data From Keychain
    class func removeKeychain(key: String) {
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue,
                                                                               service,
                                                                               key,
                                                                               kCFBooleanTrue ?? true],
                                                                     forKeys: [kSecClassValue,
                                                                               kSecAttrServiceValue,
                                                                               kSecAttrAccountValue,
                                                                               kSecReturnDataValue])

        // Delete any existing items
        let status = SecItemDelete(keychainQuery as CFDictionary)
        if (status != errSecSuccess) {
            if let err = SecCopyErrorMessageString(status, nil) {
                print("Remove failed: \(err)")
            }
        }
    }
}
