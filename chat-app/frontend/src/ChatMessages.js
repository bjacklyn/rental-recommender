import React, { useEffect, useState, useRef } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { addChat, setActiveChatId } from './chatSlice';

const ChatMessages = () => {
    const dispatch = useDispatch();
    const { activeChatId } = useSelector((state) => state.chat);
    const [input, setInput] = useState('');
    const [socket, setSocket] = useState(null);
    const [messages, setMessages] = useState([]);
    const [isSocketOpen, setIsSocketOpen] = useState(false);
    const pendingMessageRef = useRef('');
    const propertyIds = [1011101, 102, 103]; // Example list of property_ids

    const mergeChatMessages = (first, second, activeChatId) => {
        const messagesForActiveChatId = first.filter(item => item.chat_id === activeChatId);
        const existingMessageIds = new Set(messagesForActiveChatId.map(item => item.id));
        const uniqueNewChatMessages = second.filter(item => !existingMessageIds.has(item.id));
        const mergedMessages = messagesForActiveChatId.concat(uniqueNewChatMessages).sort((a, b) => new Date(a.created_at) - new Date(b.created_at));
        return mergedMessages;
    };

    const logError = (errorMessage, firstMessage, secondMessage) => {
        console.error(errorMessage);
        if (firstMessage) {
            console.error(firstMessage);
        }
        if (secondMessage) {
            console.error(secondMessage);
        }
    };

    const connectWebSocket = (chatId) => {
        const ws = new WebSocket(`/chat-app/ws/chat/${chatId}`);

        ws.onopen = () => {
            setIsSocketOpen(true);

            // Send the pending message if it exists
            if (pendingMessageRef.current) {
                ws.send(pendingMessageRef.current);
                pendingMessageRef.current = ''; // Clear pending message after sending
            }
        };

        ws.onmessage = (event) => {
            const message_splits = event.data.split(':');
            if (message_splits.length < 3) {
                logError("Unknown message is not formatted as expected", event.data);
                return;
            }

            const message_id = Number(message_splits[0]);
            const message_count = Number(message_splits[1]);
            const message_text = message_splits.slice(2).join(':');

            // The initial message contains the chat_message in json format
            if (message_count === 0) {
                var message = JSON.parse(message_text);
                message["count"] = message_count;
                setMessages((prevMessages) => mergeChatMessages(prevMessages, [message], activeChatId));
                return;
            }

            setMessages((prevMessages) => {
                const existingMessageIndex = prevMessages.findLastIndex(msg => msg.id === message_id);
                if (existingMessageIndex <= -1) {
                    logError("Unknown message received from websocket does not match any existing message..", event.data);
                    return prevMessages;
                }

                var messageToUpdate = { ...prevMessages[existingMessageIndex] }; // Create a new object for message to force react to re-render
                if (message_count === messageToUpdate.count) {
                    // Duplicate message..
                    logError("Received duplicate websocket message", event.data, messageToUpdate);
                    return prevMessages;
                } else if (message_count !== messageToUpdate.count + 1) {
                    // We missed a message..
                    logError("We missed a websocket message..", event.data, messageToUpdate);
                    return prevMessages;
                }

                messageToUpdate.count = message_count;
                messageToUpdate.response += message_text; // Append response

                return [
                    ...prevMessages.slice(0, existingMessageIndex),
                    messageToUpdate,
                    ...prevMessages.slice(existingMessageIndex + 1),
                ];
            });
        };

        ws.onclose = () => {
            setIsSocketOpen(false);
        };

        setSocket(ws);
    };

    // Fetch messages when activeChatId changes
    useEffect(() => {
        if (!activeChatId) {
            setMessages([]);
            if (socket) {
                socket.close();
                setSocket(null);
            }
            return;
        }

        const fetchChatMessages = async () => {
            const response = await fetch(`/chat-app/api/get-chat-messages/${activeChatId}`, {
                method: 'GET',
//                credentials: 'include',
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (response.ok) {
                const data = await response.json();
                setMessages((prevMessages) => mergeChatMessages(prevMessages, data, activeChatId));
            }
        };

        fetchChatMessages();

        // Clean up previous WebSocket if it exists
        if (socket) {
            socket.close();
        }

        // Reconnect WebSocket for the new chat
        connectWebSocket(activeChatId);

    }, [activeChatId]); // Dependency array

    const sendMessage = async () => {
        if (!input) return;

        const messagePayload = JSON.stringify({
            prompt: input,
            property_ids: propertyIds
        });

        // If no active chat ID, create a new chat
        if (!activeChatId) {
            const response = await fetch('/chat-app/api/new-chat', {
                method: 'POST',
//                credentials: 'include', // Include cookies for authentication
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            const data = await response.json();
            dispatch(setActiveChatId(data.id)); // Set the new chat ID
            dispatch(addChat(data)); // Add to chats
        }

        // Save the message if the socket is not open
        if (!isSocketOpen) {
            pendingMessageRef.current = messagePayload; // Set the input as the pending message
        } else {
            socket.send(messagePayload); // Send the message immediately if the socket is open
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
                    <div key={index} className="message">
                        {msg.prompt && <div className="message-prompt">{msg.prompt}</div>}
                        <div className="message-response">{msg.response}</div>
                    </div>
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

export default ChatMessages;
