//
//  DataConversion.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import Foundation

protocol DataConverter {
    func getSupportedList(supportedDictionary: [String: String]) -> [SupportedList]
    func sortSupportedList(supportedList: [SupportedList]) -> [SupportedList]
    func addSupportedListFlags(supportedList: [SupportedList]) -> [SupportedList]
    func getSupportedTitles(supportedList: [SupportedList]) -> [String]
    func getStringFirstCharacter(string: String) -> String
    func getSupportedListDictionary(supportedList: [SupportedList], supportedListWithoutFlags: [SupportedList]) -> [String: [SupportedList]]
}

extension DataConverter {

    // MARK: - Supported List

    func getSupportedList(supportedDictionary: [String: String]) -> [SupportedList] {
        var supportedList: [SupportedList] = []

        for (key, value) in supportedDictionary {
            let newSupportedItem = SupportedList(currencyCode: key, currencyName: value)
            supportedList.append(newSupportedItem)
        }

        return sortSupportedList(supportedList: supportedList)
    }

    func sortSupportedList(supportedList: [SupportedList]) -> [SupportedList] {
        var sortedSuportedList: [SupportedList] = []
        sortedSuportedList = supportedList.sorted(by: { $0.currencyName < $1.currencyName})
        return sortedSuportedList
    }

    func addSupportedListFlags(supportedList: [SupportedList]) -> [SupportedList] {
        var flaggedSupportedList: [SupportedList] = []

        for item in supportedList {
            let flaggedItem = Flags.codeToFlag[item.currencyCode]
            let newSupportedListItem = SupportedList(currencyCode: item.currencyCode, currencyName: flaggedItem!)
            flaggedSupportedList.append(newSupportedListItem)
        }

        return flaggedSupportedList
    }

    // MARK: - Supported Title

    func getSupportedTitles(supportedList: [SupportedList]) -> [String] {
        var supportedTitles: [String] = []

        // Get Currency Names
        for item in supportedList {
            supportedTitles.append(item.currencyName)
        }

        // Extract the first Letter
        for index in 0 ..< supportedTitles.count {
            supportedTitles[index] = getStringFirstCharacter(string: supportedTitles[index])
        }

        // Remove Duplicate Letters
        supportedTitles = Array(Set(supportedTitles))

        // Sort Letters
        supportedTitles = (supportedTitles.sorted(by: { $0 < $1}))

        return supportedTitles
    }

    func getStringFirstCharacter(string: String) -> String {
        return String(string.prefix(1))
    }

    // MARK: - Supported List Dictionary

    func getSupportedListDictionary(supportedList: [SupportedList], supportedListWithoutFlags: [SupportedList]) -> [String: [SupportedList]] {
        var listDictionary: [String: [SupportedList]] = [:]
        let titles = getSupportedTitles(supportedList: supportedListWithoutFlags)

        for character in titles {
            var items: [SupportedList] = []
            for index in 0 ..< supportedList.count {
                let dictionaryKey = getStringFirstCharacter(string: supportedListWithoutFlags[index].currencyName)
                if dictionaryKey == character {
                    items.append(SupportedList(currencyCode: supportedList[index].currencyCode, currencyName: supportedList[index].currencyName))
                }
                listDictionary[character] = items
            }
        }
        return listDictionary
    }
}
