import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { setChatLogs, setActiveChatId } from './chatSlice';

const ChatLogs = ({ onSelectChat }) => {
    const dispatch = useDispatch();
    const { chatLogs, activeChatId } = useSelector((state) => state.chat);

    useEffect(() => {
        const fetchChatLogs = async () => {
            const response = await fetch('http://localhost:8000/chat-app/get-chat-logs');
            const data = await response.json();
            dispatch(setChatLogs(data.chat_logs));
        };

        fetchChatLogs();
    }, [dispatch]);

    const handleChatClick = (chatLogId) => {
        dispatch(setActiveChatId(chatLogId));
        onSelectChat(chatLogId);
    };

    return (
        <div className="chat-logs">
            <h2>Previous Chats</h2>
            <ul>
                {chatLogs.map((log) => (
                    <li
                        key={log.chat_log_id}
                        className={activeChatId === log.chat_log_id ? 'active' : ''}
                        onClick={() => handleChatClick(log.chat_log_id)}
                    >
                        {log.chat_log_title}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default ChatLogs;
