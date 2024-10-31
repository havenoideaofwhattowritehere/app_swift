import React from 'react';

const ChatList = ({ chats, onSelectChat }) => {
    return (
        <div className="w-1/4 border-r p-4">
            <h2 className="text-lg font-bold">Chats</h2>
            <ul>
                {chats.map((chat) => (
                    <li
                        key={chat.id}
                        onClick={() => onSelectChat(chat)}
                        className="cursor-pointer p-2 hover:bg-gray-200"
                    >
                        {chat.title}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default ChatList;
