//
//  AlamofireNetworkingDataSource.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation

import Alamofire

class AlamofireNetworkingDataSource: NetWorkingDataSource {
    private var url: URL!

    init(url: String) {
        self.url = URL(string: url)
    }

    func loadDataFromAPI<T: Decodable>(compilitionHandler: @escaping (T?) -> Void) {
        guard let urlFinal = url else {
            print("url Error")
            return
        }

        AF.request(urlFinal).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    print("The count of data is : \(data.count)")
                    let result = try JSONDecoder().decode(T.self, from: data)
                    compilitionHandler(result)
                    print("Data Fetched Successfully...")
                } catch {
                    print("Error When Parseing data from API :  \(error.localizedDescription)")
                    compilitionHandler(nil)
                }
            case .failure(let error):
                print("Error When Featch data from API :  \(error.localizedDescription)")
                compilitionHandler(nil)
            }
        }
    }
}

