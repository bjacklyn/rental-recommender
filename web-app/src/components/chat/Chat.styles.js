import styled from "styled-components";

export const ChatContainer = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  height: 100%;
  max-width: 600px;
  margin: auto;
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: ${({ theme }) => theme.borderRadius};
  overflow: hidden;
`;

export const MessageArea = styled.div`
  flex: 1;
  overflow-y: auto;
  padding: 16px;
  background-color: ${({ theme }) => theme.colors.background};
`;

export const InputArea = styled.div`
  padding: 16px;
  border-top: 1px solid ${({ theme }) => theme.colors.border};
`;

export const MessageWrapper = styled.div`
  display: flex;
  flex-direction: column;
  align-items: ${(props) => (props.isUser ? "flex-end" : "flex-start")};
  margin-bottom: 12px;
`;

export const MessageBubble = styled.div`
  max-width: 70%;
  padding: 10px 16px;
  border-radius: 20px;
  background-color: ${(props) =>
    props.isUser ? props.theme.colors.primary : props.theme.colors.backgroundAlt};
  color: ${(props) => (props.isUser ? "#fff" : props.theme.colors.text)};
  word-wrap: break-word;
`;

export const InputWrapper = styled.div`
  display: flex;
  align-items: center;
`;