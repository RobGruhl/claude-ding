# Claude Ding

Audio notifications for Claude Code. Get notified when Claude finishes a task, asks a question, or needs permission.

## Sounds

### Celebratory (task complete)
- `claude-voila.wav` - Ta-da flourish
- `claude-sparkle.wav` - Magical sparkle
- `claude-fanfare.wav` - Mini fanfare
- `claude-crab.wav` - Crab rave snippet
- `claude-ding.wav` - Simple ding (not in rotation)

### Question (waiting for input)
- `claude-question1.wav` - Rising 3-note beep
- `claude-question2.wav` - Curious chirp with sweep
- `claude-question3.wav` - Inquisitive double-tone
- `claude-question4.wav` - Wondering chime

All sounds are 8-bit synthesized, 16-bit mono WAV at 44100 Hz.

## Installation

### Quick Install (macOS)

```bash
# Clone the repo
git clone https://github.com/yourusername/claude-ding.git
cd claude-ding

# Copy sounds to Claude config
mkdir -p ~/.claude/sounds
cp sounds/*.wav sounds/*.sh ~/.claude/sounds/
chmod +x ~/.claude/sounds/*.sh
```

### Configure Hooks

Add to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/sounds/play-random.sh",
            "timeout": 5
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "AskUserQuestion",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/sounds/play-random-question.sh",
            "timeout": 5
          }
        ]
      }
    ],
    "PermissionRequest": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/sounds/play-random-question.sh",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

Or merge with existing settings using Claude Code:

```
Ask Claude: "Add the hooks from claude-ding README to my settings.json"
```

## Hook Events

| Hook | Sound | When |
|------|-------|------|
| `Stop` | Celebratory | Claude finishes a task |
| `PostToolUse` (AskUserQuestion) | Question | Claude asks you something |
| `PermissionRequest` | Question | Claude needs permission |

## Requirements

- macOS (uses `afplay` for audio playback)
- Claude Code CLI

## Customization

### Add your own sounds

Drop any `.wav` file in `~/.claude/sounds/` and edit the scripts:

```bash
# play-random.sh - celebratory sounds
sounds=(~/.claude/sounds/claude-{voila,sparkle,fanfare,crab}.wav)

# play-random-question.sh - question sounds
sounds=(~/.claude/sounds/claude-question{1,2,3,4}.wav)
```

### Linux support

Replace `afplay` with `paplay` (PulseAudio) or `aplay` (ALSA):

```bash
# In the .sh scripts, change:
afplay "${sounds[$RANDOM % ${#sounds[@]}]}"
# To:
paplay "${sounds[$RANDOM % ${#sounds[@]}]}"
```

## How the sounds were made

Generated with ffmpeg using sine wave synthesis:

```bash
# Example: Rising 3-note question sound
ffmpeg -f lavfi -i "sine=frequency=400:duration=0.12[a];sine=frequency=500:duration=0.12[b];sine=frequency=650:duration=0.15[c];[a][b][c]concat=n=3:v=0:a=1" claude-question1.wav
```

## License

MIT
