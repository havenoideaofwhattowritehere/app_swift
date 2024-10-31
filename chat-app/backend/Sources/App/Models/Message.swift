import Fluent
import Vapor

final class Message: Model, Content {
    static let schema = "messages"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "text")
    var text: String

    @Parent(key: "chatID")
    var chat: Chat

    @Field(key: "isUserMessage")
    var isUserMessage: Bool

    init() { }

    init(id: UUID? = nil, text: String, chatID: UUID, isUserMessage: Bool) {
        self.id = id
        self.text = text
        self.$chat.id = chatID
        self.isUserMessage = isUserMessage
    }
}
