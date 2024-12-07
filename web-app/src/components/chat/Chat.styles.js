import styled from "styled-components";

const ChatAppWrapper = styled.div`
    display: flex;
    height: calc(100vh - 80px); 
    margin: 0;
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
`

const ChatContainer = styled.div`
    width: 300px; 
    padding: 10px; 
    overflow-y: auto; 
`

const ChatMessagesContainer = styled.div`
    flex: 1; 
    display: flex;
    flex-direction: column; 
    padding: 10px; 
`

const StyledChat = styled.div`
    padding-right: 20px;
`