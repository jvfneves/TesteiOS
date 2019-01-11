//
//  REST.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 14/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import Foundation

enum CarError{
    case url
    case taskError(error: Error)
    case noResponse
    case noDate
    case responseStatusCode(code: Int)
    case invalidJSON
}

class REST {
    private static let basePath = "https://floating-mountain-50292.herokuapp.com/fund.json"
    private static let basePath2 = "https://floating-mountain-50292.herokuapp.com/cells.json"
    //sessao anonima
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadCell(onCompleted: @escaping (CellModel?)-> Void){
        guard let url = URL(string: self.basePath2) else{
            onCompleted(nil)
            return
        }
        //é utilizado quando o metodo é GET
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil{
                
                guard let response = response as? HTTPURLResponse else{
                    onCompleted(nil)
                    return
                }
                
                if response.statusCode == 200{
                    
                    guard let data = data else{return}
                    do{
                        let cells = try JSONDecoder().decode(CellModel.self, from: data)
                        print("cell \(cells)")
                        onCompleted(cells)
                    }
                    catch{
                        print(error.localizedDescription)
                        onCompleted(nil)
                    }
                }
                else{
                    onCompleted(nil)
                    print("Algum status invalido pelo servidor")
                }
            }
            else{
                print(error!)
                onCompleted(nil)
            }
        }
        dataTask.resume()
    }
    
    //MARK : metodo de classe
    class func loadScreen(onCompleted: @escaping (ScreenModel)-> Void, onError: @escaping (CarError)-> Void){
        guard let url = URL(string: self.basePath) else{
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil{
                
                guard let response = response as? HTTPURLResponse else{
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200{
                    
                    guard let data = data else{return}
                    do{
                        let _screen = try JSONDecoder().decode(ScreenModel.self, from: data)
                        print("screen : \(_screen)")
                        onCompleted(_screen)
                    }
                    catch{
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                }
                else{
                    onError(.responseStatusCode(code: response.statusCode))
                    print("Algum status invalido pelo servidor")
                }
            }
            else{
                print(error!)
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
    
}
