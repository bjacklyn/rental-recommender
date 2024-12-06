import multiprocessing
from transformers import TextStreamer, AutoTokenizer
import chatbot
import json
import unittest


class TestTokenQueueStreamer(unittest.TestCase):
    def test_on_finalized_text(self):
        token_queue = multiprocessing.Queue()
        chat_message_id = 1
        tokenizer = AutoTokenizer.from_pretrained("meta-llama/Llama-3.2-1B-Instruct")
        streamer = chatbot.TokenQueueStreamer(token_queue, chat_message_id, tokenizer)

        streamer.on_finalized_text("test text", stream_end=True)

        # Allow some time for the queue to be updated
        import time
        time.sleep(1)

        self.assertFalse(token_queue.empty())
        self.assertEqual(token_queue.get(), (chat_message_id, "test text", True))





class TestChatBotPrompt(unittest.TestCase):
    def test_initialization(self):
        prompt = "Test prompt"
        chat_id = 1
        chat_message_id = 1
        property_ids = [101, 102, 103]

        chat_bot_prompt = chatbot.ChatBotPrompt(prompt, chat_id, chat_message_id, property_ids)

        self.assertEqual(chat_bot_prompt.user_prompt, prompt)
        self.assertEqual(chat_bot_prompt.chat_id, chat_id)
        self.assertEqual(chat_bot_prompt.chat_message_id, chat_message_id)
        self.assertEqual(chat_bot_prompt.property_ids, property_ids)


import unittest
from unittest.mock import MagicMock, patch
import redis
import requests


class TestChatBot(unittest.TestCase):
    def setUp(self):
        self.chat_token_queues_dict = multiprocessing.Manager().dict()
        self.chat_bot_prompts_queue = multiprocessing.Queue()
        self.chatbot = chatbot.ChatBot(self.chat_token_queues_dict, self.chat_bot_prompts_queue)

    @patch('redis.StrictRedis')
    def test_fetch_property_details(self, MockRedis):
        mock_redis_client = MockRedis.return_value
        mock_redis_client.get.side_effect = lambda x: None if x == '101' else json.dumps({"property_id": x})

        property_ids = [101, 102]
        property_details = self.chatbot.fetch_property_details(mock_redis_client, property_ids)

        self.assertIn(102, property_details)
        self.assertNotIn(101, property_details)

    @patch('requests.post')
    def test_fetch_property_details_api_call(self, mock_post):
        mock_redis_client = MagicMock()
        mock_redis_client.get.return_value = None

        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.json.return_value = [{"property_id": 101}]
        mock_post.return_value = mock_response

        property_ids = [101]
        property_details = self.chatbot.fetch_property_details(mock_redis_client, property_ids)

        self.assertIn(101, property_details)
        mock_redis_client.set.assert_called_once()


if __name__ == '__main__':
    unittest.main()