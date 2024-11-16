from langchain.llms import HuggingFaceHub
import os

os.environ["HUGGINGFACEHUB_API_TOKEN"] = "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"
class LLaMAChat:
    def __init__(self, model_name="meta-llama/Llama-3.2-3B-Instruct"):
        """
        Initialize the LLaMA model using LangChain.
        Ensure you have API access to HuggingFaceHub for this.
        """
        # Set the Hugging Face API token
        huggingface_api_token = os.getenv("HUGGINGFACEHUB_API_TOKEN")
        if not huggingface_api_token:
            raise ValueError(
                "Hugging Face API token not found. Set HUGGINGFACEHUB_API_TOKEN as an environment variable.")

        self.llm = HuggingFaceHub(repo_id=model_name, huggingfacehub_api_token=huggingface_api_token)

    def generate_response(self, prompt):
        """
        Generate a response based on the input prompt.
        """
        return self.llm(prompt)
