#!/usr/bin/env bash
# Test script for: Headroom (tier T2, time limit 1200 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
python - <<'PY'
import random
random.seed(1)
lines=[]
for i in range(3000):
    lines.append(f"2026-10-26 12:{i%60:02d}:{i%60:02d} INFO worker-{i%8} request id={random.randint(1,10**6)} path=/api/v1/items status=200 took={random.randint(1,90)}ms")
lines.insert(1700,"2026-10-26 12:28:20 FATAL worker-3 database connection pool exhausted: could not obtain connection after 30s (host=db-prod-2)")
open('sample.log','w').write("\n".join(lines))
PY
pip install -q headroom-ai >/dev/null 2>&1; pip show headroom-ai | head -2
python - <<'PY'
import time,inspect
import headroom
print("API:",[n for n in dir(headroom) if not n.startswith('_')][:25])
txt=open('sample.log').read()
try:
    from headroom import compress
    t0=time.time(); r=compress([{"role":"user","content":txt}]); dt=time.time()-t0
    print("RESULT type",type(r).__name__, str(r)[:300])
    print("METRIC compress_s=%.2f"%dt)
except Exception as e: print("ERR",repr(e)[:300])
PY
