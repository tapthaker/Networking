import Foundation
import Alamofire

public enum RequestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum NetworkError: Error {
    case SerializationError
    case NetworkFailure(String)
}



public class APIClient {

    private let sessionManager: SessionManager

    public init() {
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }

    public func request(url: String,params: [String: Any]?, method: RequestMethod, onCompletion: @escaping (Either<[String : Any], NetworkError>) -> ()) {
        sessionManager.request(url, method: HTTPMethod(rawValue: method.rawValue)!, parameters: params, encoding: JSONEncoding(), headers: nil).responseJSON { (response) in
            print(response.request)
            print(response.response)
            switch response.result {
            case .success(let successResponse):
                if let json  = successResponse as? [String : Any] {
                    onCompletion(Either.left(json))
                } else {
                    onCompletion(Either.right(NetworkError.SerializationError))
                }

            case .failure(let error):
                onCompletion(Either.right(NetworkError.NetworkFailure(error.localizedDescription)))
            }
        }
    }
}
