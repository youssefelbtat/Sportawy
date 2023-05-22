//
//  NetworkingDataSource.swift
//  Sportawy
//
//  Created by Mac on 19/05/2023.
//

import Foundation

protocol NetWorkingDataSource {
    func setURL(_ url: String)
    func loadDataFromAPI<T: Decodable>(compilitionHandler: @escaping (T?) -> Void)

}
