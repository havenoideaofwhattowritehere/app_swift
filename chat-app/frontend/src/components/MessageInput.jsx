import React, { useState } from 'react';

const MessageInput = ({ onSendMessage }) => {
    const [message, setMessage] = useState('');

    const handleSend = () => {
        onSendMessage(message);
        setMessage('');
    };

    return (
        <div className="flex">
            <input
                type="text"
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                className="flex-1 border border-gray-300 rounded p-2"
                placeholder="Type your message..."
            />
            <button onClick={handleSend} className="ml-2 bg-blue-500 text-white px-4 rounded">
                Send
            </button>
        </div>
    );
};

export default MessageInput;
