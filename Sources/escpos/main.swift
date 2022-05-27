import Foundation

// enum Error: Swift.Error {
//     case noPathGiven
//     case failedToLoadData
// }

@available(macOS 10.14, *)
func initClient(server: String, port: UInt16, initialData: Data) {
    let client = Client(host: server, port: port)
    client.start()
    client.connection.send(data: Data([0x1B, 0x40])) // Initialize
    client.connection.send(data: Data([0x1D, 0x61, 0x04])) // Real-time status
    client.connection.send(data: initialData)
    while(true) {
        var command = readLine(strippingNewline: true)
        switch (command){
        case "CRLF":
            command = "\r\n"
        case "RETURN":
            command = "\n"
        case "exit":
            client.stop()
        default:
            break
        }
        var data = Data()
        data.append((command?.data(using: .utf8))!)
        client.connection.send(data: data)
    }
}

let port: UInt16 = 9100
let server = CommandLine.arguments[1]
print("Starting as client, connecting to server: \(server) port: \(port)")

let path = CommandLine.arguments[2]
let url = URL(fileURLWithPath: path)
guard let data = try? Data(contentsOf: url) else {
    // throw Error.failedToLoadData
    exit(1)
}


if #available(macOS 10.14, *) {
    initClient(server: server, port: port, initialData: data)
} else {
    // Fallback on earlier versions
}

RunLoop.current.run()
