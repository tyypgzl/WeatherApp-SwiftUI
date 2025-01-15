//
//  WeatherHeader.swift
//  WeatherApp
//
//  Created by Tayyip Güzel on 14.01.2025.
//

import SwiftUI

struct WeatherHeader: View {
    @State private var searchText = ""
    let onSearch: (String) -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("London...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding([.top, .leading, .bottom])
            .padding()
            Button(action: {
                onSearch(searchText)
            }) {
                Text("Search")
            }
            .buttonStyle(.automatic)
            .padding([.top, .trailing, .bottom])
        }
    }
}


#Preview {
    WeatherHeader(
        onSearch:  { text in
            
        }
    )
}
