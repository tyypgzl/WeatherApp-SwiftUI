//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Tayyip Güzel on 14.01.2025.
//

import SwiftUI

struct WeatherView: View {
    @State private var viewModel = WeatherViewModel()
    @State private var searchText = ""
    
    var body: some View {
            VStack {
                WeatherHeader(
                    onSearch: { searchText in
                        viewModel.fetchWeather(city: searchText)
                    }
                )
                if viewModel.loading {
                    LoadingView()
                } else {
                    if viewModel.weather != nil {
                        WeatherBody(viewModel: $viewModel)
                    } else {
                        Spacer()
                        Image(systemName: "hourglass.bottomhalf.fill")
                            .font(.system(size: 72))
                        Text("Please search some city..")
                            .padding()
                        Spacer()
                    }
                    
                    
                }
               
            }

    }


}




#Preview {
    WeatherView()
}

