import logo from './logo.svg';
import './App.css';
import { useState } from 'react';
import ChatMessages from './ChatMessages';
import Chats from './Chats';

function App() {
    const [chatId, setChatId] = useState('');

    const onSelectChat = (id) => {
        setChatId(id); // Update the selected chat ID
    };

  return (
    <div className="chat-app">
        <div className="chats-container">
            <Chats onSelectChat={onSelectChat} />
        </div>
        <div className="chat-messages-container">
            <ChatMessages chatId={chatId} />
        </div>
    </div>
  );
}

export default App;
