import React from 'react';
import MessageInput from './MessageInput';

const ChatWindow = ({ chat, messages, onSendMessage }) => {
    return (
        <div className="w-3/4 p-4">
            <h2 className="text-lg font-bold">{chat.title}</h2>
            <div className="h-96 overflow-y-scroll border border-gray-300 p-2">
                {messages.map((msg) => (
                    <div key={msg.id} className={msg.isUserMessage ? 'text-right' : 'text-left'}>
                        <p className={`inline-block px-2 py-1 rounded ${msg.isUserMessage ? 'bg-blue-500 text-white' : 'bg-gray-200'}`}>
                            {msg.text}
                        </p>
                    </div>
                ))}
            </div>
            <MessageInput onSendMessage={onSendMessage} />
        </div>
    );
};

export default ChatWindow;
