# Security

## What this kit touches

`brain-backup.ps1` reads the memory folders under `C:\Users\<you>\.claude\projects\*\memory\` and writes copies of them into the Brain folder you configure in `$brainRoot`. That is all it does.

- No network calls. The script never leaves your machine; off-machine backup happens only if you place the Brain inside a folder your own sync client (such as OneDrive) watches.
- No credentials read, stored or sent.
- The SessionEnd hook in `settings-hook-snippet.json` runs that one script and nothing else.

## Privacy note

Claude Code memory files can contain anything Claude was asked to remember. If you put the Brain in a synced or shared location, you are choosing to sync that content. Point `$brainRoot` at a private folder if that is not what you want.

## Turning it off

Remove the SessionEnd entry from `C:\Users\<you>\.claude\settings.json` (or open `/hooks` in Claude Code and disable it there). Deleting the Brain folder removes every copy the kit made; the original memories under `~\.claude\projects\` are never modified.

## Reporting

Open a GitHub issue, or email hello@awmium.com for anything sensitive.
