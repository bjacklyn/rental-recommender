import axios from "axios";

const BASE_API_URL = "http://rentalrecommender.cloud:8000";

// Fetch all chats for the current user
export const getChats = async () => {
  const response = await axios.get(`${BASE_API_URL}/api/get-chats`);
  return response.data.chats;
};

// Fetch messages for a specific chat
export const getChatMessages = async (chatId) => {
  const response = await axios.get(`${BASE_API_URL}/api/get-chat-messages/${chatId}`);
  return response.data;
};

// Create a new chat
export const createChat = async () => {
  const response = await axios.post(`${BASE_API_URL}/api/new-chat`);
  return response.data;
};

// Delete a specific chat
export const deleteChat = async (chatId) => {
  const response = await axios.delete(`${BASE_API_URL}/api/delete-chat/${chatId}`);
  return response.data;
};
