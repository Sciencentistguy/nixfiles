"""Run dr-rs on an album folder once Picard has finished saving it."""

import os
import subprocess
import threading

from picard.plugin3.api import PluginApi

DR_BIN = "@dr@"
DELAY = 5  # seconds to wait for the rest of the album to finish saving

_pending = {}
_lock = threading.Lock()


def _run(api, folder):
    with _lock:
        _pending.pop(folder, None)
    api.logger.info("Running dr on %s", folder)
    result = subprocess.run([DR_BIN, folder], check=False)
    if result.returncode != 0:
        api.logger.warning("dr exited with status %d for %s", result.returncode, folder)


def on_file_saved(api, file):
    folder = os.path.dirname(file.filename)  # the final path, after any renaming
    with _lock:
        if folder in _pending:
            _pending[folder].cancel()  # another track saved, so restart the timer
        timer = threading.Timer(DELAY, _run, [api, folder])
        _pending[folder] = timer
        timer.start()


def enable(api: PluginApi) -> None:
    api.register_file_post_save_processor(on_file_saved)


def disable() -> None:
    with _lock:
        for timer in _pending.values():
            timer.cancel()
        _pending.clear()
