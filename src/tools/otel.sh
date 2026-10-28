#!/usr/bin/env bash
# Test script for: OpenTelemetry (python) (tier T2, time limit 400 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
pip install -q opentelemetry-sdk >/dev/null 2>&1
python - <<'PY'
import time
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import SimpleSpanProcessor, SpanExporter, SpanExportResult
class N(SpanExporter):
    def export(self,s): return SpanExportResult.SUCCESS
trace.set_tracer_provider(TracerProvider()); trace.get_tracer_provider().add_span_processor(SimpleSpanProcessor(N()))
tr=trace.get_tracer("x"); t0=time.time()
for i in range(100000):
    with tr.start_as_current_span("s"): pass
print("METRIC spans_per_s=%d"%(100000/(time.time()-t0)))
PY
