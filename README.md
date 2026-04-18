# Mem0 REST API Server (Ollama enabled)

Mem0 provides a REST API server (written using FastAPI). Users can perform all operations through REST endpoints. The API also includes OpenAPI documentation, accessible at `/docs` when the server is running.

## Features

- **Create memories:** Create memories based on messages for a user, agent, or run.
- **Retrieve memories:** Get all memories for a given user, agent, or run.
- **Search memories:** Search stored memories based on a query.
- **Update memories:** Update an existing memory.
- **Delete memories:** Delete a specific memory or all memories for a user, agent, or run.
- **Reset memories:** Reset all memories for a user, agent, or run.
- **OpenAPI Documentation:** Accessible via `/docs` endpoint.

## Ollama integration

Mem0 can use Ollama as an open-model provider. To enable Ollama, set the following environment variables in your `.env` or shell (do not store secrets in public repos):

- `MEM0_OPEN_MODEL_PROVIDER=ollama`
- `MEM0_OPEN_MODEL_BASE_URL` (example: `http://host.docker.internal:11434`)
- `MEM0_LLM_MODEL` (example: `qwen2.5:7b`)
- `MEM0_EMBEDDER_MODEL` (example: `nomic-embed-text-v2-moe:latest`)
- `MEM0_EMBEDDER_DIMENSION` (example: `768`)

Restart the server after updating environment variables.

**Test**

Post
```shell
curl -X POST http://localhost:8888/memories \
     -H "Content-Type: application/json" \
     -d '{"messages": [{"role": "user", "content": "I love playing tennis on weekends"}], "user_id": "test_user"}'
```

Verify
```shell
curl 'http://localhost:8888/memories?user_id=test_user'
```

Reset (Warning - Distructive)
```shell
curl -X POST http://localhost:8888/reset
```


## Running the server

Follow the instructions in the [docs](https://docs.mem0.ai/open-source/features/rest-api) to run the server.

```shell
docker compose up -d --build
```