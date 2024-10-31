mport Vapor

struct ChatController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let chats = routes.grouped("chats")
        chats.get(use: index)
        chats.post(use: create)
        
        chats.group(":chatID") { chat in
            chat.get("messages", use: getMessages)
            chat.post("messages", use: addMessage)
        }
    }
    
    func index(req: Request) async throws -> [Chat] {
        do {
            return try await Chat.query(on: req.db).all()
        } catch {
            throw Abort(.internalServerError, reason: "Could not fetch chats.")
        }
    }

    func create(req: Request) async throws -> Chat {
        do {
            let chat = try req.content.decode(Chat.self)
            try await chat.save(on: req.db)
            return chat
        } catch {
            throw Abort(.badRequest, reason: "Invalid data. Could not create chat.")
        }
    }

    func getMessages(req: Request) async throws -> [Message] {
        guard let chatID = req.parameters.get("chatID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid chat ID.")
        }
        
        do {
            return try await Message.query(on: req.db)
                .filter(\.$chat.$id == chatID)
                .all()
        } catch {
            throw Abort(.internalServerError, reason: "Could not fetch messages for the chat.")
        }
    }

    func addMessage(req: Request) async throws -> Message {
        guard let chatID = req.parameters.get("chatID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid chat ID.")
        }
        
        do {
            var message = try req.content.decode(Message.self)
            message.$chat.id = chatID
            try await message.save(on: req.db)
            
            // Generate AI response
            let aiResponse = try await generateAIResponse(for: message.text, on: req)
            let aiMessage = Message(text: aiResponse, chatID: chatID, isUserMessage: false)
            try await aiMessage.save(on: req.db)
            
            return aiMessage
        } catch {
            throw Abort(.internalServerError, reason: "Could not send message or fetch AI response.")
        }
    }

    func generateAIResponse(for message: String, on req: Request) async throws -> String {
        let url = URI(string: "https://api.openai.com/v1/your-endpoint") 
        var request = HTTPClientRequest(url: url)
        request.method = .POST
        request.headers.add(name: "Authorization", value: "Bearer YOUR_OPENAI_API_KEY")

        request.body = .init(string: """
        {
            "prompt": "\(message)",
            "max_tokens": 50
        }
        """)

        do {
            let response = try await req.client.send(request).get()
            guard response.status == .ok else {
                throw Abort(.internalServerError, reason: "Failed to get a response from OpenAI.")
            }
            return try response.content.decode(OpenAIResponse.self).choices.first?.text ?? "No response"
        } catch {
            throw Abort(.internalServerError, reason: "Could not fetch AI response.")
        }
    }
}
