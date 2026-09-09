import sys
from pathlib import Path

HERE = Path(__file__).parent
for _p in (HERE / "python" / "src", HERE.parent / "_common" / "python"):
    _s = str(_p)
    if _p.is_dir() and _s not in sys.path:
        sys.path.insert(0, _s)
