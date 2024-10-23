import logo from './logo.svg';
import './App.css';
import { useState } from 'react';
import Chat from './Chat';
import ChatLogs from './ChatLogs';

function App() {
    const [chatId, setChatId] = useState('');

    const onSelectChat = (id) => {
        setChatId(id); // Update the selected chat ID
    };

  return (
    <div className="chat-app">
        <div className="chat-logs-container">
            <ChatLogs onSelectChat={onSelectChat} />
        </div>
        <div className="chat-container">
            <Chat chatId={chatId} />
        </div>
    </div>
  );
}

export default App;
