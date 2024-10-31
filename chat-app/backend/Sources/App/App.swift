import Vapor
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) throws {
    // Database configuration
    app.databases.use(.postgres(hostname: Environment.get("DATABASE_HOST") ?? "localhost",
                                 username: Environment.get("DATABASE_USERNAME") ?? "user",
                                 password: Environment.get("DATABASE_PASSWORD") ?? "password",
                                 database: Environment.get("DATABASE_NAME") ?? "chatapp_db"),
                      as: .psql)

    // Migrations
    app.migrations.add(CreateChat())
    app.migrations.add(CreateMessage())

    // Routes
    try routes(app)
}
