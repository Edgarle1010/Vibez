//
//  APIManager.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 02/01/22.
//

import Foundation

protocol APIManagerDelegate {
    func didUpdateQuestion(_ apiManager: APIManager, question: Questions)
}

struct APIManager {
    
    var delegate: APIManagerDelegate?
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let question = parseJSON(safeData) {
                        delegate?.didUpdateQuestion(self, question: question)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ apiData: Data) -> Questions? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(APIData.self, from: apiData)
            
            let text = decodedData.questions[0].text
            let total = decodedData.questions[0].total
            let charData = decodedData.questions[0].chartData
            
            let question = Questions(total: total, text: text, chartData: charData)
            return question
            
        } catch {
            print(error)
            return nil
        }
    }
}
