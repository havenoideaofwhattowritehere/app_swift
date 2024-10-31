import Fluent

struct CreateMessage: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("messages")
            .id()
            .field("text", .string, .required)
            .field("chatID", .uuid, .required, .references("chats", "id"))
            .field("isUserMessage", .bool, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("messages").delete()
    }
}
