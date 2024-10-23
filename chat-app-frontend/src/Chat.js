import React, { useEffect, useState, useRef } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { addChatLog, setActiveChatId } from './chatSlice';

const Chat = () => {
    const dispatch = useDispatch();
    const { activeChatId } = useSelector((state) => state.chat);
    const [input, setInput] = useState('');
    const [socket, setSocket] = useState(null);
    const [messages, setMessages] = useState([]);
    const [isSocketOpen, setIsSocketOpen] = useState(false);
    const pendingMessageRef = useRef('');

    const connectWebSocket = (chatLogId) => {
        const ws = new WebSocket(`ws://localhost:8000/chat-app/ws/chat/${chatLogId}`);

        ws.onopen = () => {
            setIsSocketOpen(true);

            // Send the pending message if it exists
            if (pendingMessageRef.current) {
                ws.send(pendingMessageRef.current);
                pendingMessageRef.current = ''; // Clear pending message after sending
            }
        };

        ws.onmessage = (event) => {
            const message = event.data;
            setMessages((prevMessages) => [...prevMessages, message]);
        };

        ws.onclose = () => {
            setIsSocketOpen(false);
        };

        setSocket(ws);
    };

    // Fetch messages when activeChatId changes
    useEffect(() => {
        if (!activeChatId) return;

        const fetchChatMessages = async () => {
            const response = await fetch(`http://localhost:8000/chat-app/get-chat-messages/${activeChatId}`, {
                method: 'GET',
//                credentials: 'include',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (response.ok) {
                const data = await response.json();
                setMessages(data.map(item => item.response));
            }
        };

        fetchChatMessages();

        // Clean up previous WebSocket if it exists
        if (socket) {
            socket.close();
        }

        // Reconnect WebSocket for the new chat log
        connectWebSocket(activeChatId);

    }, [activeChatId]); // Dependency array includes activeChatId

    const sendMessage = async () => {
        if (!input) return;

        // If no active chat ID, create a new chat log
        if (!activeChatId) {
            const response = await fetch('http://localhost:8000/chat-app/new-chat', {
                method: 'POST',
//                credentials: 'include', // Include cookies for authentication
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            const data = await response.json();
            dispatch(setActiveChatId(data.chat_log_id)); // Set the new chat ID
            dispatch(addChatLog(data)); // Add to chat logs
        }

        // Save the message if the socket is not open
        if (!isSocketOpen) {
            pendingMessageRef.current = input; // Set the input as the pending message
        } else {
            socket.send(input); // Send the message immediately if the socket is open
        }

        // Clear the input
        setInput('');
    };

    const handleKeyDown = (e) => {
        if (e.key === 'Enter') {
            sendMessage();
        }
    };

    return (
        <div className="chat-area">
            <div className="messages">
                {messages.map((msg, index) => (
                    <div key={index} className="message">{msg}</div>
                ))}
            </div>
            <input
                type="text"
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyDown={handleKeyDown}
                placeholder="Type a message..."
            />
            <button onClick={sendMessage}>Send</button>
        </div>
    );
};

export default Chat;
