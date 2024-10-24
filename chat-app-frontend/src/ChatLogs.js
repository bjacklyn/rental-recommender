import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { setChatLogs, setActiveChatId, addChatLog, removeChatLog } from './chatSlice';

const ChatLogs = ({ onSelectChat }) => {
    const dispatch = useDispatch();
    const { chatLogs, activeChatId } = useSelector((state) => state.chat);

    useEffect(() => {
        const fetchChatLogs = async () => {
            const response = await fetch('http://localhost:8000/chat-app/get-chat-logs');
            const data = await response.json();
            const sortedLogs = data.chat_logs.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
            dispatch(setChatLogs(sortedLogs));
        };

        fetchChatLogs();
    }, [dispatch]);

    const handleChatClick = (chatLogId) => {
        dispatch(setActiveChatId(chatLogId));
        onSelectChat(chatLogId);
    };

    const handleNewChat = async () => {
        const response = await fetch('http://localhost:8000/chat-app/new-chat', {
            method: 'POST',
//            credentials: 'include',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (response.ok) {
            const data = await response.json();
            dispatch(setActiveChatId(data.id)); // Update Redux
            dispatch(addChatLog(data)); // Add new chat log to Redux state
        }
    };

    const handleDeleteChat = async (event, chatLogId) => {
        event.stopPropagation(); // Prevent the click from bubbling up

        const response = await fetch(`http://localhost:8000/chat-app/delete-chat/${chatLogId}`, {
            method: 'DELETE',
//            credentials: 'include',
        });

        if (response.ok) {
            // Remove chat log from state
            setChatLogs(chatLogs.filter(log => log.chat_log_id !== chatLogId));

            // Optionally, if the deleted chat was active, reset the active chat
            if (activeChatId === chatLogId) {
                dispatch(setActiveChatId(null));
                onSelectChat(null);
            }

            dispatch(removeChatLog(chatLogId)); // Dispatch to update Redux state if needed
        } else {
            // Handle error (e.g., show a notification)
            console.error('Failed to delete chat');
        }
    };

    return (
        <div className="chat-logs">
            <div className="chat-header">
                <h2>Chats</h2>
                <button onClick={handleNewChat} className="new-chat-button">+</button>
            </div>
            <ul>
                {chatLogs.map((log) => (
                    <li
                        key={log.id}
                        onClick={() => handleChatClick(log.id)}
                    >
                        <span className={activeChatId === log.id ? 'active' : ''}>
                            {log.created_at}
                        </span>
                        <button
                            className="delete-button"
                            onClick={(event) => handleDeleteChat(event, log.id)}
                        >
                            x
                        </button>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default ChatLogs;
