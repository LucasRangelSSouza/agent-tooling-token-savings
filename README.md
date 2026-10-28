# Agent tooling: token savings and observability

Headroom context compression and OpenTelemetry span throughput measured on CPU.

Author: Lucas Rangel. All numbers below come from `evidence/results.json` (measured runs on rented Vast.ai GPUs, Oct 2026). Rows with failed or install-only status are not included. Every row is a real run on a shared marketplace host: values are single-session medians, outliers are kept (not filtered), and a different host of the same GPU model can differ noticeably.

## Conclusion

One call of the context compression library took 2.74 s on a synthetic 3,001-line log (library import included). No token counts before and after were recorded, so token savings were NOT measured and the overhead cannot be called negligible. The OpenTelemetry Python SDK emitted 37,939 spans per second in a tight single-process loop.

## Measured rows

| tool | tier | wall (s) | peak RSS (MB) | metrics |
|---|---|---|---|---|
| Headroom | T2 | 34.6 | 129 | compress_s=2.74 |
| OpenTelemetry (python) | T2 | 7.0 | 59 | spans_per_s=37939.0 |

## What this cost

These were CPU-only runs on small rented instances (cents per run).

Whole campaign: US$ 50.79 (about R$ 249), shared by all repositories of this series. Rental share of the GPUs used in this repo:

| GPU | rentals | hours | rental cost (USD) |
|---|---|---|---|

Rental figures are hourly price x time of each rented instance; marketplace download fees and idle time are in the campaign total, not in this table.

## Reproduce

`bash scripts/run.sh` documents the exact commands used on the rented instance (Ubuntu, CUDA, Python venv). Evidence files are the unmodified measured rows (host location and reliability removed).
