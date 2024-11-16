from llama_model import LLaMAChat

# Initialize the LLaMA model
llama = LLaMAChat()

# Test the model with a prompt
response = llama.generate_response("What is the capital of France?")
print("LLaMA Response:", response)
