import { createSlice } from '@reduxjs/toolkit';

const chatSlice = createSlice({
    name: 'chat',
    initialState: {
        chats: [],
        activeChatId: null,
    },
    reducers: {
        setChats(state, action) {
            state.chats = action.payload;
        },
        addChat(state, action) {
            state.chats.unshift(action.payload);
        },
        removeChat(state, action) {
            state.chats = state.chats.filter(chat => chat.id != action.payload);
        },
        setActiveChatId(state, action) {
            state.activeChatId = action.payload;
        },
    },
});

export const { setChats, addChat, removeChat, setActiveChatId } = chatSlice.actions;
export default chatSlice.reducer;
