import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
S = json.loads((ROOT / "results" / "summary.json").read_text())


def test_both_measured_tools_produced_a_metric():
    assert S["m_headroom_compress_s"] > 0 and S["m_otel_spans_per_s"] > 1000


def test_no_token_savings_claim_is_possible_from_this_data():
    # the headroom test printed a time, not before/after token counts
    assert not any(k.startswith("m_headroom_") and "token" in k for k in S)
