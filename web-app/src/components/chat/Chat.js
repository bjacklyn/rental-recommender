import React, { useState, useEffect, useRef } from "react";
import PropTypes from "prop-types";
import { ChatContainer, MessageArea, InputArea, MessageWrapper, MessageBubble, InputWrapper } from "./Chat.styles";
import { Input, Button } from "antd";

const Chat = ({ initialMessages }) => {
  const [messages, setMessages] = useState(initialMessages);
  const [inputValue, setInputValue] = useState("");
  const messageEndRef = useRef(null);

  // Scroll to the latest message
  const scrollToBottom = () => {
    messageEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSendMessage = () => {
    if (!inputValue.trim()) return;

    const newMessage = {
      id: Date.now(),
      sender: "user",
      content: inputValue.trim(),
      timestamp: new Date().toLocaleTimeString(),
    };

    setMessages([...messages, newMessage]);
    setInputValue("");

    // Simulate a bot response
    setTimeout(() => {
      const botMessage = {
        id: Date.now() + 1,
        sender: "bot",
        content: "Got it! How can I assist further?",
        timestamp: new Date().toLocaleTimeString(),
      };
      setMessages((prevMessages) => [...prevMessages, botMessage]);
    }, 1000);
  };

  return (
    <ChatContainer>
      <MessageArea>
        {messages.map((message) => (
          <MessageWrapper key={message.id} isUser={message.sender === "user"}>
            <MessageBubble isUser={message.sender === "user"}>
              {message.content}
            </MessageBubble>
            <small>{message.timestamp}</small>
          </MessageWrapper>
        ))}
        <div ref={messageEndRef} />
      </MessageArea>
      <InputArea>
        <InputWrapper>
          <Input
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            placeholder="Type your message..."
            onPressEnter={handleSendMessage}
          />
          <Button type="primary" onClick={handleSendMessage} style={{ marginLeft: "8px" }}>
            Send
          </Button>
        </InputWrapper>
      </InputArea>
    </ChatContainer>
  );
};

Chat.propTypes = {
  initialMessages: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      sender: PropTypes.string.isRequired,
      content: PropTypes.string.isRequired,
      timestamp: PropTypes.string.isRequired,
    })
  ),
};

Chat.defaultProps = {
  initialMessages: [],
};

export default Chat;