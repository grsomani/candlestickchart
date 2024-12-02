//
//  ContentView.swift
//  CandleStick
//
//  Created by Ganesh on 01/12/24.
//

import SwiftUI
import Charts

struct PriceData: Identifiable {
    let id = UUID()
    var timePeriod: Date
    var openPrice: Double
    var closePrice: Double
    var high: Double
    var low: Double
}

let currentTime = Date.now
let calendar = Calendar.current

var priceData: [PriceData] = [
    .init(timePeriod: calendar.date(byAdding: .hour, value: -4, to: currentTime)!,
          openPrice: 10,
          closePrice: 20,
          high: 25,
          low: 5),
    .init(timePeriod: calendar.date(byAdding: .hour, value: -3, to: currentTime)!,
          openPrice: 22,
          closePrice: 20,
          high: 20,
          low: 15),
    .init(timePeriod: calendar.date(byAdding: .hour, value: -2, to: currentTime)!,
          openPrice: 20,
          closePrice: 25,
          high: 25,
          low: 10),
    .init(timePeriod: calendar.date(byAdding: .hour, value: -1, to: currentTime)!,
          openPrice: 23,
          closePrice: 30,
          high: 35,
          low: 15),
    .init(timePeriod: currentTime,
          openPrice: 12,
          closePrice: 25,
          high: 25,
          low: 5),
    .init(timePeriod: calendar.date(byAdding: .hour, value: 1, to: currentTime)!,
          openPrice: 22,
          closePrice: 20,
          high: 20,
          low: 15),
    .init(timePeriod: calendar.date(byAdding: .hour, value: 2, to: currentTime)!,
          openPrice: 20,
          closePrice: 25,
          high: 25,
          low: 15),
    .init(timePeriod: calendar.date(byAdding: .hour, value: 3, to: currentTime)!,
          openPrice: 25,
          closePrice: 31,
          high: 32,
          low: 17)
]


struct ContentView: View {
    @State private var selectedPrice: Double?
    
    var body: some View {
        NavigationView {
            Chart {
                ForEach(priceData) { item in
                    let chartColor: Color = item.closePrice > item.openPrice ? .green : .red
                    RectangleMark(x: .value("Day", item.timePeriod),
                                  yStart: .value("Open", item.openPrice),
                                  yEnd: .value("Close", item.closePrice),
                                  width: 4)
                    .foregroundStyle(chartColor)
                    
                    RectangleMark(x: .value("Day", item.timePeriod),
                                  yStart: .value("Low", item.low),
                                  yEnd: .value("High", item.high),
                                  width: 1)
                    .foregroundStyle(chartColor)
                }
                
                if (selectedPrice != nil) {
                    RuleMark(y: .value("Price", selectedPrice ?? 0.0))
                        .foregroundStyle(Color.black)
                        .annotation {
                            Text("\(selectedPrice ?? 0.0, specifier: "%.2f")")
                        }
                }
            }
            .chartYSelection(value: $selectedPrice)
            .navigationBarTitle("Charts")
        }
    }
}

#Preview {
    ContentView()
}
