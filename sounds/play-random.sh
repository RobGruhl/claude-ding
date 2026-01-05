#!/bin/bash
sounds=(~/.claude/sounds/claude-{voila,sparkle,fanfare,crab,happy1,happy2,happy3,happy4}.wav)
afplay "${sounds[$RANDOM % ${#sounds[@]}]}"
