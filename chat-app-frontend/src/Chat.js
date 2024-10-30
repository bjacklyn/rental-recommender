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

    const mergeChatMessages = (first, second, activeChatId) => {
        const messagesForActiveChatId = first.filter(item => item.chat_log_id === activeChatId);
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
            const message = JSON.parse(event.data);

            if (message.type !== "initial" && message.type !== "partial" && message.type !== "complete") {
                logError("Unknown message type received..", message);
                return;
            }

            if (message.type === "initial") {
                setMessages((prevMessages) => mergeChatMessages(prevMessages, [message], activeChatId));
                return;
            }

            setMessages((prevMessages) => {
                const existingMessageIndex = prevMessages.findIndex(msg => msg.id === message.id);
                if (existingMessageIndex <= -1) {
                    logError("Unknown message received from websocket does not match any existing message..", message);
                    return prevMessages;
                }

                var messageToUpdate = { ...prevMessages[existingMessageIndex] }; // Create a new object for message to force react to re-render
                if (message.count === messageToUpdate.count) {
                    // Duplicate message..
                    logError("Received duplicate websocket message", message, messageToUpdate);
                    return prevMessages;
                } else if (message.count !== messageToUpdate.count + 1) {
                    // We missed a message..
                    logError("We missed a websocket message..", message, messageToUpdate);
                    return prevMessages;
                }

                // If we got here then this message is in fact the next expected message
                if (message.type === "partial") {
                    if (messageToUpdate.type !== "initial" && messageToUpdate.type !== "partial") {
                        logError("Received partial message after completion..", message, messageToUpdate);
                        return prevMessages;
                    }

                    messageToUpdate.type = message.type;
                    messageToUpdate.count = message.count;
                    messageToUpdate.response += message.response; // Append response
                    console.log(message.response);
                } else if (message.type === "complete") {
                    delete messageToUpdate.type;
                    delete messageToUpdate.count;
                }

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
            const response = await fetch(`http://localhost:8000/chat-app/get-chat-messages/${activeChatId}`, {
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
            dispatch(setActiveChatId(data.id)); // Set the new chat ID
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
                    <div key={index} className="message">{msg.response}</div>
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
