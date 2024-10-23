import { createSlice } from '@reduxjs/toolkit';

const chatSlice = createSlice({
    name: 'chat',
    initialState: {
        chatLogs: [],
        activeChatId: null,
    },
    reducers: {
        setChatLogs(state, action) {
            state.chatLogs = action.payload;
        },
        addChatLog(state, action) {
            state.chatLogs.push(action.payload);
        },
        setActiveChatId(state, action) {
            state.activeChatId = action.payload;
        },
    },
});

export const { setChatLogs, addChatLog, setActiveChatId } = chatSlice.actions;
export default chatSlice.reducer;
