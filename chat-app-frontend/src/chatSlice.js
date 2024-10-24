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
            state.chatLogs.unshift(action.payload);
        },
        removeChatLog(state, action) {
            state.chatLogs = state.chatLogs.filter(log => log.id != action.payload);
        },
        setActiveChatId(state, action) {
            state.activeChatId = action.payload;
        },
    },
});

export const { setChatLogs, addChatLog, removeChatLog, setActiveChatId } = chatSlice.actions;
export default chatSlice.reducer;
