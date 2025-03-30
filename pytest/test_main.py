from main import get_block_number, get_block_by_number

def test_get_block_number():
    response = get_block_number()
    assert "result" in response

def test_get_block_by_number():
    response = get_block_by_number("1")
    assert "result" in response
