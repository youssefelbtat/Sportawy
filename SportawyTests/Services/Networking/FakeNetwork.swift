//
//  FakeNetwork.swift
//  SportawyTests
//
//  Created by Mac on 30/05/2023.
//

import Foundation
@testable import Sportawy

class FakeNetwork{
    
    var shouldReturnError : Bool
    
    let mockResponseData = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 4,
                    "league_name": "UEFA Europa League",
                    "country_key": 1,
                    "country_name": "eurocups",
                    "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                    "country_logo": null
                },
                {
                    "league_key": 1,
                    "league_name": "European Championship",
                    "country_key": 1,
                    "country_name": "eurocups",
                    "league_logo": null,
                    "country_logo": null
                }
            ]
        }
    """.data(using: .utf8)!

    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    enum ResposeWithError : Error {
        case responseError
    }
    
}

extension FakeNetwork : NetWorkingDataSource {
    
    func loadDataFromAPI<T>(compilitionHandler: @escaping (T?) -> Void) where T : Decodable {
        
        if shouldReturnError{
            compilitionHandler(nil)
        }else{
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: mockResponseData)
                compilitionHandler(responseData)
                
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
            
        }
    }
    
    func setURL(_ url: String) {
        
    }
    
}
