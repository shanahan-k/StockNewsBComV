//
//  ApiManager.swift
//  StockNews
//
//  Created by Collins, Matthew - MC on 22/03/2023.
//

import Foundation

class ApiManager: ObservableObject {
    
    let apiKey: String
    static let shared = ApiManager()
    @Published var results: [ApiResult]? = nil
    
    private init() {
        apiKey = "0HC_ThU3h3wLpxMmtROZKlp6RfZPyI4t"
    }
    
    func getTickers() async {
        
        // INSTANTIATE AND HANDLE A NEW URL OBJECT
        guard let url = URL(string: "https://api.polygon.io/v3/reference/tickers?market=stocks&exchange=XNYS&active=true&apiKey=\(self.apiKey)") else {
            print("Invalid URL")
            return
        }
        
        do {
            // START A URL SESSION TO GET DATA
            let (data, _) = try await URLSession.shared.data(from: url)

            // DECODE THE DATA TO BE ABLE TO MAKE SENSE OF IT IN JSON
            if let decodedResponse = try? JSONDecoder().decode(ApiResults.self, from: data) {
                print(decodedResponse)
                
                DispatchQueue.main.async {
                    self.results = decodedResponse.results
                }
            }
        }
        catch {
            print("Invalid data")
        }
    }
}
