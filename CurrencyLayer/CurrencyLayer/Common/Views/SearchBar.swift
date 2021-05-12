//
//  SearchHeader.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 14/12/20.
//

import SwiftUI
struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
          _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          text = searchText.uppercased()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .default
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
