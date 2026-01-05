#!/bin/bash
sounds=(~/.claude/sounds/claude-{voila,sparkle,fanfare,crab}.wav)
afplay "${sounds[$RANDOM % ${#sounds[@]}]}"
