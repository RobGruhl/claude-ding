# Claude Ding

Audio notifications for Claude Code. Get notified when Claude finishes a task, asks a question, or needs permission.

## Sounds

### Celebratory (task complete)
- `claude-voila.wav` - Ta-da flourish
- `claude-sparkle.wav` - Magical sparkle
- `claude-fanfare.wav` - Mini fanfare
- `claude-crab.wav` - Crab rave snippet
- `claude-happy1.wav` - R2-D2 style excited warble
- `claude-happy2.wav` - Ascending chirp trio with vibrato
- `claude-happy3.wav` - Celebratory trill with sustain
- `claude-happy4.wav` - Victory whistle with vibrato sweep
- `claude-ding.wav` - Simple ding (not in rotation)

### Question (waiting for input)
- `claude-question1.wav` - Rising 3-note beep
- `claude-question2.wav` - Curious chirp with sweep
- `claude-question3.wav` - Inquisitive double-tone
- `claude-question4.wav` - Wondering chime
- `claude-question5.wav` - R2-D2 style curious warble
- `claude-question6.wav` - Hesitant pause then rising query
- `claude-question7.wav` - Puzzled descent then sharp rise
- `claude-question8.wav` - Wondering chirp sequence

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
# play-random.sh - celebratory sounds (8 sounds)
sounds=(~/.claude/sounds/claude-{voila,sparkle,fanfare,crab,happy1,happy2,happy3,happy4}.wav)

# play-random-question.sh - question sounds (8 sounds)
sounds=(~/.claude/sounds/claude-question{1,2,3,4,5,6,7,8}.wav)
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

Generated with ffmpeg using sine wave synthesis, inspired by Ben Burtt's R2-D2 sound design:
- Frequency modulation for warbles and vibrato
- Rising pitch contours for questions (like vocal inflection)
- Layered tones for character
- Sample-and-hold style stepped frequencies

```bash
# Simple rising 3-note question
ffmpeg -f lavfi -i "sine=frequency=400:duration=0.12[a];sine=frequency=500:duration=0.12[b];sine=frequency=650:duration=0.15[c];[a][b][c]concat=n=3:v=0:a=1" claude-question1.wav

# R2-D2 style warble with vibrato (happy1)
ffmpeg -f lavfi -i "aevalsrc='0.5*sin(2*PI*(600+200*sin(25*PI*t)+150*t/0.4)*t)':d=0.4" claude-happy1.wav

# Hesitant then rising query (question6)
ffmpeg -f lavfi -i "aevalsrc='0.4*sin(2*PI*(380+20*sin(8*PI*t))*t)':d=0.15[a];anullsrc=d=0.08[gap];aevalsrc='0.6*sin(2*PI*(420+300*t/0.25+40*sin(25*PI*t))*t)':d=0.25[b];[a][gap][b]concat=n=3:v=0:a=1" claude-question6.wav
```

## License

MIT
