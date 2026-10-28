#!/usr/bin/env bash
# Test script for: GEPA (tier T1, time limit 400 s)
# Run by src/sandbox/sandbox_suite.py inside an isolated HOME on a small CPU instance.
pip install -q gepa >/dev/null 2>&1; python -c "import gepa;print('gepa',getattr(gepa,'__version__','?'));print([n for n in dir(gepa) if not n.startswith('_')][:20])" 
