# Download LLM inside backend/ directory:
```
huggingface-cli download meta-llama/Llama-3.2-3B-Instruct
```
Note: This will require first:
- Creating an account on huggingface.co
- Pip installing the huggingface-cli
- Accepting the terms and conditions for this model from facebook
- `huggingface-cli login`

# Build:
```
docker build . --tag chat-app:1.0
```

# Run:
```
docker run --rm --init --runtime=nvidia -it --gpus all --network=host chat-app:1.0
```

Note: You need to install and configure the nvidia-container-toolkit for the runtime to work. Runtime is needed to use GPU (which LLM needs).
