from .env import load_env, is_debug
from .logging import setup_logging
from .paths import SCRIPTS_DIR, REPO_ROOT, PACKS_DIR, DIST_DIR

# Re-export to other scripts
__all__ = [
    SCRIPTS_DIR,
    REPO_ROOT,
    PACKS_DIR,
    DIST_DIR,
    setup_logging,
    load_env,
    is_debug,
]

# Immediately load the env and setup logging when imported
load_env()
setup_logging()
