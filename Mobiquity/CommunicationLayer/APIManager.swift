//
//  APIManager.swift
//  Mobiquity Test
//
//  Created by Ram on 31/03/21.
//

import Foundation
import CoreLocation
enum NetworkEnvironment {
    case stage
}
class APIManager : NSObject {
    static let networkEnviroment: NetworkEnvironment = .stage
    static private var instance : APIManager {
        return APIManager()
    }
    private override init() {
        super.init()
    }
    static func sharedManager() -> APIManager {
        return instance
    }
    
    func getWeatherData<T>(type: EndPointType, loc : CLLocation , decodingType: T.Type, completion:@escaping  (Result<T, Error>)->()) where T: Decodable {
        
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: type.url + "\(KeyConstant.lat)=\(loc.coordinate.latitude)&" + "\((KeyConstant.lon))=\(loc.coordinate.longitude)" + type.path )!,timeoutInterval: Double.infinity)
        request.httpMethod = type.httpMethod

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error?.localizedDescription as! Error))
                semaphore.signal()
                return
            }

            let httpStatus = response as? HTTPURLResponse
            switch httpStatus?.statusCode {
            case 200:
                
                do{
                    let jsonDict = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                    debugPrint(jsonDict)
                    let result =  try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch let jsonErr{
                    
                    completion(.failure(jsonErr ))
                    
                }
                semaphore.signal()
                break
            default:
                break
            }
          
        }

        task.resume()
        semaphore.wait()
    }
    
}
