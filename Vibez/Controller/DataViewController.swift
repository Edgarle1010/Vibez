//
//  DataViewController.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 02/01/22.
//

import UIKit
import Charts

class DataViewController: UIViewController, APIManagerDelegate {
    @IBOutlet weak var question1Label: UILabel!
    @IBOutlet weak var pieView: PieChartView!
    
    let apiURL = "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld"
    
    var apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        
        pieView.showLoading(style: .gray)
        apiManager.performRequest(urlString: apiURL)
    }
    
    func didUpdateQuestion(_ apiManager: APIManager, question: Questions) {
        DispatchQueue.main.async {
            self.question1Label.text = question.text
            
            if let firstValue = question.chartData[0].percetnage,
               let firstText = question.chartData[0].text,
               let secondValue = question.chartData[1].percetnage,
               let secondText = question.chartData[1].text{
                self.setupPieChart(firstValue, secondValue, firstText, secondText)
            }
            
            self.pieView.stopLoading()
        }
        
    }
    
    func setupPieChart(_ firstValue: Int, _ secondValue: Int, _ firstText: String, _ secondText: String) {
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
        pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = false
        
        //pieView.legend.enabled = false
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: Double(firstValue), label: "\(firstText): \(firstValue)%"))
        entries.append(PieChartDataEntry(value: Double(secondValue), label: "\(secondText): \(secondValue)%"))
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        let c1 = UIColor.red
        let c2 = UIColor.blue
        
        dataSet.colors = [c1, c2]
        dataSet.drawValuesEnabled = false
        
        pieView.data = PieChartData(dataSet: dataSet)
    }
    
}
