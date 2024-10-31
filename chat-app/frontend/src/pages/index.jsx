import React, { useEffect, useState } from 'react';
import ChatList from '../components/ChatList';
import ChatWindow from '../components/ChatWindow';
import axios from 'axios';

const HomePage = () => {
    const [chats, setChats] = useState([]);
    const [selectedChat, setSelectedChat] = useState(null);
    const [messages, setMessages] = useState([]);

    useEffect(() => {
        const fetchChats = async () => {
            const response = await axios.get('/api/chats');
            setChats(response.data);
        };
        fetchChats();
    }, []);

    const handleSelectChat = async (chat) => {
        setSelectedChat(chat);
        const response = await axios.get(`http://localhost:8080/chats/${chat.id}/messages`);
        setMessages(response.data);
    };

    const handleSendMessage = async (text) => {
        if (selectedChat) {
            const response = await axios.post(`http://localhost:8080/chats/${selectedChat.id}/messages`, {
                text,
                isUserMessage: true,
            });
            setMessages([...messages, response.data]);
        }
    };

    return (
        <div className="flex">
            <ChatList chats={chats} onSelectChat={handleSelectChat} />
            {selectedChat && (
                <ChatWindow
                    chat={selectedChat}
                    messages={messages}
                    onSendMessage={handleSendMessage}
                />
            )}
        </div>
    );
};

export default HomePage;
