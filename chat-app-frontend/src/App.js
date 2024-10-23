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
    <div className="App">
        <h1>Chat Application</h1>
        <ChatLogs onSelectChat={onSelectChat} />
        <Chat chatId={chatId} />
    </div>
  );
}

export default App;
