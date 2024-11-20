//
//  SearchBar.swift
//  FlickrApp
//
//  Created by Vishnu on 19/11/24.
//

import Foundation
import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    var onSearch: () -> Void // Callback for when Enter is pressed
    
    var body: some View {
        HStack {
            // Textfield - Search bar
            TextField("Search images", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
                .accessibilityIdentifier("Search Bar")
                .accessibilityAddTraits([.isSearchField])
                .onSubmit {
                    onSearch()
                }
        }
        .padding(.all, 8)
    }
}
