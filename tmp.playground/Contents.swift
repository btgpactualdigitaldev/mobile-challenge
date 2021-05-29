import Foundation
let stringURl = "http://apilayer.net/api/live?access_key=dde04e1875ba595553125a47e403d12c"
let url = URL(string: stringURl)!
URLSession.shared.dataTask(with: url) { (data, re, err) in
    debugPrint(data)
    debugPrint(re)
    debugPrint(err)
}.resume()
