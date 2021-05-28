//
//  LineChart.swift
//  GoalSet
//
//  Created by Yoshikazu Tsuka on 2021/05/27.
//

import SwiftUI
import Charts

struct LineChart: UIViewRepresentable {
    
    typealias UIViewType = LineChartView
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChartView = LineChartView()
        lineChartView.data = setData()
        
        lineChartView.backgroundColor = .darkGray
        lineChartView.data!.setValueFont(.systemFont(ofSize: 20, weight: .light))
        lineChartView.data!.setValueTextColor(.white)
        lineChartView.data!.setDrawValues(false)
        lineChartView.rightAxis.enabled = false
        lineChartView.animate(xAxisDuration: 1)
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        
        //Y軸表示の設定
        let yAxis = lineChartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(5, force: true)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        //X軸表示の設定
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(5, force: true)
        xAxis.labelTextColor = .white
        xAxis.axisLineColor = .white
        xAxis.granularity = 1.0
        let formatter = DateValueFormatter(startDate: Date())
        xAxis.valueFormatter = formatter
        
        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
    
    let yValue:[ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 10.0),
        ChartDataEntry(x: 2, y: 20.0),
        ChartDataEntry(x: 3, y: 30.0),
        ChartDataEntry(x: 4, y: 40.0),
        ChartDataEntry(x: 5, y: 20.0)
    ]
    
    func setData() -> LineChartData {
        
        let dataPoint = getDataPoints(accuracy: yValue)
        
        let set = LineChartDataSet(entries: dataPoint, label: "My data")
        let data = LineChartData(dataSet: set)
        
        set.mode = .cubicBezier
        set.drawCirclesEnabled = false
        set.lineWidth = 3
        set.setColor(.cyan)
        set.fill = Fill(color: .white)
        set.fillAlpha = 0.5
        set.drawFilledEnabled = true
        
        return data
    }
    
    func getDataPoints(accuracy: [ChartDataEntry]) -> [ChartDataEntry] {
        var dataPoints: [ChartDataEntry] = []
        
        for count in (0..<accuracy.count) {
            dataPoints.append(ChartDataEntry(x: Double(count), y: accuracy[count].y))
        }
        return dataPoints
    }
    
    
}



class DateValueFormatter: NSObject, IAxisValueFormatter {

    let dateFormatter = DateFormatter()
    var startDate: Date

    init(startDate:Date) {
        self.startDate = startDate
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: Int(value), to: startDate)!
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: modifiedDate)
    }
}
