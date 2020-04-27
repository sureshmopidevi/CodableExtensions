import Foundation
import UIKit


extension Encodable {
    typealias JSON = [String: Any]
    func encode(_ options: JSONSerialization.ReadingOptions = .allowFragments) -> Data? {
        if let data = try? JSONEncoder().encode(self) {
            return data
        } else {
            print("UNABLE TO ENCODE DATA FROM MODEL \(String(describing: self))")
            return nil
        }
    }
}

// MARK: Data Extensions

extension Data {
    /// Converting Data to JSON
    var JSON: [String: Any] {
        if let jsonObject: [String: Any] = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? JSON {
            return jsonObject
        } else {
            return [:]
        }
    }
    
    /// Converting Data to String
    var toString: String {
        return String(data: self, encoding: .utf8) ?? "UNABLE TO GET STRING"
    }
    
    /// Converting Data to Decodable Model
    /// - Parameter type: Type is a decodable class or structure which must confirm to decodable protocol,
    /// - Returns: returns the specified type of model from Data
    func decodeTo<T>(of type: T.Type) -> T? where T : Decodable {
        if let model = try? JSONDecoder().decode(type.self, from: self) {
            return model
        } else {
            return nil
        }
    }
    
}

// MARK: Dictionary Extensions

extension Dictionary {
    /// Converting Dictionary to String
    var toString: String {
        return self.description
    }
    /// Converting Dictionary to Data
    var toData: Data {
        return self.description.data(using: .utf8) ?? Data()
    }

    /// Converting Data to Decodable Model
    /// - Parameter type: Type is a decodable class or structure which must confirm to decodable protocol,
    /// - Returns: returns the specified type of model from Data
    func decodeTo<T>(of type: T.Type) -> T? where T: Decodable {
        if let model = try? JSONDecoder().decode(type.self, from: self.toData) {
            return model
        } else {
            return nil
        }
    }
}

// MARK: String Extensions

extension String {
    /// Converting String to Data
    var toData: Data {
        return self.data(using: .utf8) ?? Data()
    }

    /// Converting String to JSON Dictionary
    var JSON: [String: Any] {
        if let json = try? JSONSerialization.jsonObject(with: self.toData, options: .allowFragments) as? JSON {
            return json
        } else {
            return [:]
        }
    }
    
    /// Converting Data to Decodable Model
    /// - Parameter type: Type is a decodable class or structure which must confirm to decodable protocol,
    /// - Returns: returns the specified type of model from Data
    func decodeTo<T: Decodable>(of type: T.Type) -> T? {
        if let model = try? JSONDecoder().decode(type.self, from: self.toData) {
            return model
        } else {
            return nil
        }
    }
}


// MARK: Example

struct User: Codable {
    var fullName: String = "Suresh Mopidevi"
    var profession: String = "iOS Developer"

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case profession
    }
}

let user: User = User()

// model
debugPrint(user)

// MARK: Encoding

let encodedData = user.encode()

// MARK: Data extensions

if let unwrappedData = encodedData {
    // To String
    debugPrint(unwrappedData.toString)

    // To JSON Dictionary
    debugPrint(unwrappedData.JSON)

    // decoding from Data
    // Following techniques used to decode
    debugPrint(unwrappedData.decodeTo(of: User.self)!)
    debugPrint(unwrappedData.JSON.decodeTo(of: User.self)!)
    debugPrint(unwrappedData.toString.decodeTo(of: User.self)!)
}
