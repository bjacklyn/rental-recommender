import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import Chat from "./Chat";

test("renders initial messages", () => {
  const initialMessages = [
    { id: 1, sender: "user", content: "Hi", timestamp: "10:00 AM" },
    { id: 2, sender: "bot", content: "Hello", timestamp: "10:01 AM" },
  ];
  render(<Chat initialMessages={initialMessages} />);

  expect(screen.getByText(/Hi/i)).toBeInTheDocument();
  expect(screen.getByText(/Hello/i)).toBeInTheDocument();
});

test("sends a new message", () => {
  render(<Chat initialMessages={[]} />);
  const input = screen.getByPlaceholderText("Type your message...");
  const sendButton = screen.getByText("Send");

  fireEvent.change(input, { target: { value: "Test message" } });
  fireEvent.click(sendButton);

  expect(screen.getByText(/Test message/i)).toBeInTheDocument();
});