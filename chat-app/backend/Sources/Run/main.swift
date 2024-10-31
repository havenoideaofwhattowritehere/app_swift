import Vapor

// Entry point for the application
public func main() throws {
    let app = Application()
    defer { app.shutdown() }

    try configure(app)

    try app.run()
}

try main()
