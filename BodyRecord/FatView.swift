//
//  FatView.swift
//  BodyRecord
//
//  Created by HellöM on 2020/7/1.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import Charts

class FatView: LineChartView {
    
    var bodyFats: Array<Double> = []
    var dates: Array<String> = []
    
    override func didMoveToSuperview() {
        
        delegate = self
        
        dragEnabled = false
        setScaleEnabled(false)
        pinchZoomEnabled = false
        highlightPerDragEnabled = false
        legend.enabled = false
        rightAxis.enabled = false
        noDataText = "沒有數據"
        animate(yAxisDuration: 2)
        
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = true
        if userData.count == 1 {
            xAxis.granularity = 2
        } else {
            xAxis.granularity = 1
        }
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.valueFormatter = self
        
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelCount = 8
        leftAxis.gridLineDashLengths = [3.0,3.0]
        //        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        //        leftAxis.drawGridLinesEnabled = true
        //        leftAxis.granularityEnabled = true
        //        leftAxis.granularity = 0.5
        //        leftAxis.axisMinimum = 0
        //        leftAxis.axisMaximum = 210
        //        leftAxis.labelTextColor = .gray
        
        if userData.count != 0 {
            setChart()
        }
    }
    
    func setChart() {
        
        bodyFats = userData.map { (objc) -> Double in
            
            let age = (objc.value(forKey: "age")! as! Double)
            let gender = (objc.value(forKey: "gender")! as! Double)
            let meter = (objc.value(forKey: "bodyHeight")! as! Double) / 100
            let dHight = meter * meter
            let bodyWeight = objc.value(forKey: "bodyWeight")! as! Double
            let bmi = bodyWeight / dHight
            let bodyFat = (1.2 * bmi) + (0.23 * Double(age) - 5.4) - (10.8 * Double(gender))
            return bodyFat
        }.reversed()
        
        dates = userData.map { (objc) -> String in
            
            let date = String((objc.value(forKey: "date")! as! String).suffix(5))
            return date
        }.reversed()
        
        
        
        var values: Array<ChartDataEntry> = []
        for (index, value) in bodyFats.enumerated() {
            
            let chartDataEntry = ChartDataEntry(x: Double(index), y: Double(value), data: dates)
            values.append(chartDataEntry)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "Line DataSet")
        set1.axisDependency = .left
        set1.mode = .cubicBezier
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.lineWidth = 1.5
        set1.drawCirclesEnabled = true
        set1.drawValuesEnabled = false
        set1.highlightEnabled = false
        set1.fillAlpha = 0.26
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = true
        
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        self.data = data
    }
}

extension FatView: ChartViewDelegate {
    
    
}

extension FatView: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dates[Int(value)]
    }
}
