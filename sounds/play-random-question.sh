#!/bin/bash
sounds=(~/.claude/sounds/claude-question{1,2,3,4}.wav)
afplay "${sounds[$RANDOM % ${#sounds[@]}]}"
