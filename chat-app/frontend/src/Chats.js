import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { setChats, setActiveChatId, addChat, removeChat } from './chatSlice';

const Chats = ({ onSelectChat }) => {
    const dispatch = useDispatch();
    const { chats, activeChatId } = useSelector((state) => state.chat);

    useEffect(() => {
        const fetchChats = async () => {
            const response = await fetch('/chat-app/api/get-chats');
            const data = await response.json();
            const sortedChats = data.chats.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
            dispatch(setChats(sortedChats));
        };

        fetchChats();
    }, [dispatch]);

    const handleChatClick = (chatId) => {
        dispatch(setActiveChatId(chatId));
        onSelectChat(chatId);
    };

    const handleNewChat = async () => {
        const response = await fetch('/chat-app/api/new-chat', {
            method: 'POST',
//            credentials: 'include',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (response.ok) {
            const data = await response.json();
            dispatch(setActiveChatId(data.id)); // Update Redux
            dispatch(addChat(data)); // Add new chat log to Redux state
        }
    };

    const handleDeleteChat = async (event, chatId) => {
        event.stopPropagation(); // Prevent the click from bubbling up

        const response = await fetch(`/chat-app/api/delete-chat/${chatId}`, {
            method: 'DELETE',
//            credentials: 'include',
        });

        if (response.ok) {
            // Remove chat from state
            setChats(chats.filter(chat => chat.id !== chatId));

            // Optionally, if the deleted chat was active, reset the active chat
            if (activeChatId === chatId) {
                dispatch(setActiveChatId(null));
                onSelectChat(null);
            }

            dispatch(removeChat(chatId)); // Dispatch to update Redux state if needed
        } else {
            // Handle error (e.g., show a notification)
            console.error('Failed to delete chat');
        }
    };

    return (
        <div className="chats">
            <div className="chat-header">
                <h2>Chats</h2>
                <button onClick={handleNewChat} className="new-chat-button">+</button>
            </div>
            <ul>
                {chats.map((chat) => (
                    <li
                        key={chat.id}
                        onClick={() => handleChatClick(chat.id)}
                    >
                        <span className={activeChatId === chat.id ? 'active' : ''}>
                            {chat.created_at}
                        </span>
                        <button
                            className="delete-button"
                            onClick={(event) => handleDeleteChat(event, chat.id)}
                        >
                            x
                        </button>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default Chats;
