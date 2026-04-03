#!/bin/bash
set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ZecKit External Smoke Test"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 1. Check Zebra Miner
echo "1. Checking Zebra Miner RPC..."
curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getblockcount","params":[]}' \
     -H 'content-type: application/json' \
     http://127.0.0.1:8232 | grep -q "result"
echo "✓ Zebra Miner is responding"

# 2. Check Faucet
echo "2. Checking Faucet API..."
curl -s http://127.0.0.1:8080/stats | grep -q "current_balance"
echo "✓ Faucet is operational"

# 3. Check Zcash Address (Example)
echo "3. Retrieving Faucet Address..."
FAUCET_ADDR=$(curl -s http://127.0.0.1:8080/address | jq -r .unified_address)
echo "✓ Faucet UA: ${FAUCET_ADDR:0:30}..."

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✓ ALL VERIFICATION TESTS PASSED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
