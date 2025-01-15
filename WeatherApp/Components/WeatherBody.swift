//
//  WeatherBody.swift
//  WeatherApp
//
//  Created by Tayyip Güzel on 14.01.2025.
//

import SwiftUI

struct WeatherBody: View {
    @Binding var viewModel: WeatherViewModel
    
    var body: some View {
        Spacer()
        Text(viewModel.weather?.location?.name ?? "")
            .font(.system(size: 35))
            .bold()
        Text(viewModel.date(epoch: viewModel.currentForecastDay?.dateEpoch) ?? "")
            .font(.system(size: 18))
        AsyncImage(
            url: viewModel.iconUrl()
        )
        .frame(width: 128, height: 128)
            .font(.system(size: 180))
            .shadow(radius: 75)
        Text("\(viewModel.temp) °C")
            .font(.system(size: 70))
            .bold()
        Text(viewModel.text ?? "")
            .font(.system(size: 22))
            .bold()
        Spacer()
        Spacer()
        Spacer()
        List(viewModel.forecastDays ?? []) { forecast in
            HStack(alignment: .center, spacing: nil) {
                Text(viewModel.date(epoch: forecast.dateEpoch) ?? "")
                    .frame(maxWidth: 50, alignment: .leading)
                    .bold()
                AsyncImage(
                    url: viewModel.iconUrl(icon: forecast.day?.condition?.icon),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .frame(width: 36, height: 36)

                if let tempC = forecast.day?.avgtempC {
                    let formatted = String(format: "%.1f", tempC)
                    Text("\(formatted) °C")
                        .frame(maxWidth: 50, alignment: .leading)
                }
                Spacer()
                if let condition = forecast.day?.condition?.text {
                    Text(condition)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
        }
        .contentMargins(.vertical, 0)
        .scrollContentBackground(.hidden)
        Spacer()
        Text("Data suplied by Weather API")
            .font(.system(size: 14))
    }
}

#Preview {
    WeatherBody(viewModel: .constant(WeatherViewModel()))
}
