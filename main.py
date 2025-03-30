from fastapi import FastAPI
import requests
import uvicorn

def get_polygon_rpc_response(method: str, params=None):
    POLYGON_RPC_URL = "https://polygon-rpc.com/"
    payload = {"jsonrpc": "2.0", "method": method, "params": params or [], "id": 2}
    response = requests.post(POLYGON_RPC_URL, json=payload)
    return response.json()

app = FastAPI()

@app.get("/block/number")
def get_block_number():
    return get_polygon_rpc_response("eth_blockNumber")

@app.get("/block/{block_number}")
def get_block_by_number(block_number: str):
    hex_block_number = hex(int(block_number))  # Convert to hex format
    return get_polygon_rpc_response("eth_getBlockByNumber", [hex_block_number, True])

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)