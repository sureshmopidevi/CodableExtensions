# CodableExtensions
Helpers for Encoding and Decoding 

### Example

```swift
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
```
