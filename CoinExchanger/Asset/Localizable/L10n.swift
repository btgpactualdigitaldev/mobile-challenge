//
//  L10n.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 09/06/21.
//

import Foundation

internal enum L10n {
    // SYSTEM
    internal enum System {
        
        // MARK: BUTTON
        internal enum Button {
            /// OK
            internal static let ok = L10n.tr("Localizable", "system.button.ok")
            ///
            internal static let okHint = L10n.tr("Localizable", "system.button.okHint")
        }

        // MARK: ERROR
        internal enum Error {
            /// CONEXAO
            internal static let connection = L10n.tr("Localizable", "system.error.connection")
            /// DADOS
            internal static let storage = L10n.tr("Localizable", "system.error.storage")
            
            // MARK: PERMISSION
            internal enum Permission {
                /// GALLERY
                internal static let gallery = L10n.tr("Localizable", "system.error.permission.gallery")
            }
        }
    }
    
    // COIN
    internal enum Coin {
        
        // MARK: CONVERTER
        internal enum Converter {
            /// DADOS ATUALIZADO EM
            internal static let date = L10n.tr("Localizable", "coin.converter.date")
            ///
            internal static let dateHint = L10n.tr("Localizable", "coin.converter.dateHint")
            /// VALOR
            internal static let hint = L10n.tr("Localizable", "coin.converter.hint")
            /// $$$
            internal static let originCoin = L10n.tr("Localizable", "coin.converter.originCoin")
            ///
            internal static let originCoinHint = L10n.tr("Localizable", "coin.converter.originCoinHint")
            ///
            internal static let originFieldHint = L10n.tr("Localizable", "coin.converter.originFieldHint")
            /// MOEDA DE ORIGEM
            internal static let originLabel = L10n.tr("Localizable", "coin.converter.originLabel")
            ///
            internal static let switchHint = L10n.tr("Localizable", "coin.converter.switchHint")
            /// ¥¥¥
            internal static let targetCoin = L10n.tr("Localizable", "coin.converter.targetCoin")
            ///
            internal static let targetCoinHint = L10n.tr("Localizable", "coin.converter.targetCoinHint")
            ///
            internal static let targetFieldHint = L10n.tr("Localizable", "coin.converter.targetFieldHint")
            /// MOEDA DE INTERESSE
            internal static let targetLabel = L10n.tr("Localizable", "coin.converter.targetLabel")
        }

        // MARK: LIST
        internal enum List {
            /// DADOS DO SERVIDOR
            internal static let emptyList = L10n.tr("Localizable", "coin.list.emptyList")
            /// NÂO ENCONTROU RESULTADOS
            internal static let emptySearch = L10n.tr("Localizable", "coin.list.emptySearch")
            /// NOME DA MOEDA
            internal static let search = L10n.tr("Localizable", "coin.list.search")
            ///
            internal static let searchHint = L10n.tr("Localizable", "coin.list.searchHint")
            /// MOEDAS
            internal static let title = L10n.tr("Localizable", "coin.list.title")
            ///
            internal static let ordenateAZ = L10n.tr("Localizable", "coin.list.ordenateAZ")
            ///
            internal static let ordenateID = L10n.tr("Localizable", "coin.list.ordenateID")
        }
    }
}

// MARK: - Implementation Details
extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
