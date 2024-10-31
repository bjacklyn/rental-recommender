# Build:
```
docker build . --tag chat-app:1.0
```

# Run:
```
docker run --rm --init --runtime=nvidia -it --gpus all --network=host chat-app:1.0
```

Note: You need to install and configure the nvidia-container-toolkit for the runtime to work. Runtime is needed to use GPU (which LLM needs).
