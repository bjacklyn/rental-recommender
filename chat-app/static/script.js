let currentChatId = '';

async function startNewChat() {
    currentChatId = generateChatId();
    document.getElementById('chat-output').innerHTML = '<div>New chat started!</div>';
    
    // Add the new chat to the list
    const chatList = document.getElementById('chat-list');
    const chatItem = document.createElement('li');
    chatItem.innerText = currentChatId;
    chatItem.onclick = () => loadChat(currentChatId);
    chatItem.classList.add('active-chat');
    chatList.appendChild(chatItem);
    
    updateActiveChatDisplay();
}

function generateChatId() {
    return 'chat_' + Date.now(); // Generate a unique chat ID
}

async function sendMessage() {
    const userInput = document.getElementById('user-input').value;
    if (userInput.trim() && currentChatId) {
        const botResponse = "This is a placeholder response."; // Replace with actual bot logic
        
        // Store the chat interaction
        await fetch('/chat-app/chat/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ chat_id: currentChatId, user_message: userInput, bot_response: botResponse }),
        });
        
        document.getElementById('chat-output').innerHTML += `<div>User: ${userInput}</div>`;
        document.getElementById('chat-output').innerHTML += `<div>Bot: ${botResponse}</div>`;
        document.getElementById('user-input').value = ''; // Clear input field
    }
}

async function loadChat(chatId) {
    const response = await fetch(`/chat-app/load-chat/${chatId}`);
    const data = await response.json();
    
    document.getElementById('chat-output').innerHTML = '';
    data.chats.forEach(chat => {
        document.getElementById('chat-output').innerHTML += `<div>User: ${chat[1]}</div>`;
        document.getElementById('chat-output').innerHTML += `<div>Bot: ${chat[2]}</div>`;
    });
    
    currentChatId = chatId;
    updateActiveChatDisplay(chatId);
}

function updateActiveChatDisplay() {
    const chatItems = document.querySelectorAll('#chat-list li');
    chatItems.forEach(item => {
        item.classList.remove('active-chat');
        if (item.innerText === currentChatId) {
            item.classList.add('active-chat');
            document.getElementById('active-chat-title').innerText = currentChatId;
        }
    });
}
