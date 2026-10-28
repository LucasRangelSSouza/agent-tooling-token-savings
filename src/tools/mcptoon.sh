#!/usr/bin/env bash
# Test script for: mcptoon (tier T2, time limit 600 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
pip install -q mcptoon >/dev/null 2>&1; mcptoon status 2>&1 | head -8; mcptoon bench 2>&1 | tail -8
