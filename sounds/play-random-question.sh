#!/bin/bash
sounds=(~/.claude/sounds/claude-question{1,2,3,4,5,6,7,8}.wav)
afplay "${sounds[$RANDOM % ${#sounds[@]}]}"
