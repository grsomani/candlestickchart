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
    var day: Int
    var openPrice: Double
    var closePrice: Double
    var high: Double
    var low: Double
}

var priceData: [PriceData] = [
    .init(day: 1, openPrice: 10, closePrice: 20, high: 25, low: 5),
    .init(day: 2, openPrice: 22, closePrice: 20, high: 20, low: 15),
    .init(day: 3, openPrice: 20, closePrice: 25, high: 25, low: 10),
    .init(day: 4, openPrice: 23, closePrice: 30, high: 35, low: 15)
]


struct ContentView: View {
    
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    var body: some View {
        NavigationStack {
            Chart {
                ForEach(priceData) { item in
                    let chartColor: Color = item.closePrice > item.openPrice ? .green : .red
                    RectangleMark(x: .value("Day", item.day),
                                  yStart: .value("Low Price", item.openPrice),
                                  yEnd: .value("High Price", item.closePrice),
                                  width: 4)
                    .foregroundStyle(chartColor)
                    
                    RectangleMark(x: .value("Day", item.day),
                                  yStart: .value("Low Price", item.low),
                                  yEnd: .value("High Price", item.high),
                                  width: 1)
                    .foregroundStyle(chartColor)
                }
            }
            .padding(20)
            .scaleEffect(currentZoom + totalZoom < 1 ? 1 : currentZoom + totalZoom)
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        currentZoom = value.magnification - 1
                    }
                    .onEnded { value in
                        totalZoom += currentZoom
                        currentZoom = 0
                    }
            )
        }
        .navigationTitle("Charts")
    }
}

#Preview {
    ContentView()
}
