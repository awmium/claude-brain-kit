# Contributing

Small kit, small rules.

- Open an issue first for anything beyond a typo; the kit's scope is deliberately narrow (mirror on SessionEnd, recall via CLAUDE.md) and pull requests that grow it need a conversation.
- An rsync port for macOS and Linux would be a welcome contribution: same behaviour, `brain-backup.sh`, mirror semantics preserved.
- Keep `brain-backup.ps1` compatible with Windows PowerShell 5.1.
- Test on a real machine: run the script, end a session, check `last-backup.txt` and the mirrors.
