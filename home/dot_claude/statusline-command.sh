#!/usr/bin/env bash
# Claude Code status line - inspired by Starship Gruvbox Dark theme

# Gruvbox Dark ANSI color codes (using 256-color approximations)
# color_orange = #d65d0e -> 166
# color_yellow = #d79921 -> 136
# color_aqua   = #689d6a -> 72
# color_blue   = #458588 -> 66
# color_purple = #b16286 -> 132
# color_bg3    = #665c54 -> 59
# color_bg1    = #3c3836 -> 237
# color_fg0    = #fbf1c7 -> 230

FG="\033[38;5;230m"
BG_ORANGE="\033[48;5;166m"
FG_ORANGE="\033[38;5;166m"
BG_YELLOW="\033[48;5;136m"
FG_YELLOW="\033[38;5;136m"
BG_AQUA="\033[48;5;72m"
FG_AQUA="\033[38;5;72m"
BG_BLUE="\033[48;5;66m"
FG_BLUE="\033[38;5;66m"
BG_PURPLE="\033[48;5;132m"
FG_PURPLE="\033[38;5;132m"
BG_BG3="\033[48;5;59m"
FG_BG3="\033[38;5;59m"
BG_BG1="\033[48;5;237m"
FG_BG1="\033[38;5;237m"
RESET="\033[0m"

# Powerline separators (UTF-8 hex bytes for bash 3.x compat)
SEP=$'\xee\x82\xb0'
SEP_START=$'\xee\x82\xb6'
SEP_END=$'\xee\x82\xb4'

input=$(cat)

# Extract fields from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')

# Shorten the path: replace $HOME with ~, truncate to last 3 segments
home_dir="$HOME"
short_path="${cwd/#$home_dir/\~}"
# Truncate to at most 3 path segments
truncated=$(echo "$short_path" | awk -F'/' '{
    n=NF
    if(n>3){
        print "…/" $(n-2) "/" $(n-1) "/" $n
    } else {
        print $0
    }
}')

# Git branch (skip lock to be safe)
git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree --quiet 2>/dev/null 1>/dev/null; then
    git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Git status indicators
git_status_str=""
if [ -n "$git_branch" ]; then
    git_dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | head -1)
    if [ -n "$git_dirty" ]; then
        git_status_str="*"
    fi
fi

# Context window usage
ctx_str=""
if [ -n "$used_pct" ]; then
    # Round to integer
    used_int=$(printf "%.0f" "$used_pct")
    ctx_str=" ${used_int}%"
fi

# Human-readable token count
fmt_tokens() {
    local n="$1"
    if [ -z "$n" ] || [ "$n" = "null" ]; then echo "0"; return; fi
    if [ "$n" -ge 1000000 ]; then
        printf "%.1fM" "$(echo "$n / 1000000" | bc -l)"
    elif [ "$n" -ge 1000 ]; then
        printf "%.1fK" "$(echo "$n / 1000" | bc -l)"
    else
        echo "$n"
    fi
}

# Token usage string
usage_str=""
if [ -n "$total_input" ] || [ -n "$total_output" ]; then
    in_fmt=$(fmt_tokens "${total_input:-0}")
    out_fmt=$(fmt_tokens "${total_output:-0}")
    usage_str="↑${in_fmt} ↓${out_fmt}"
    if [ -n "$cost_usd" ] && [ "$cost_usd" != "0" ]; then
        cost_fmt=$(printf "\$%.2f" "$cost_usd")
        usage_str+=" ${cost_fmt}"
    fi
fi

# Time
time_str=$(date +%H:%M)

# Build the status line as two independent powerline rows.
# Terminal width is not exposed to statusline scripts (no TTY, no JSON field),
# so a fixed 2-line layout avoids the narrow-terminal truncation bug where CC
# silently drops lines that exceed the actual terminal width.

# Line 1: identity (user@host, path, git)
line1="${FG_ORANGE}${SEP_START}"
line1+="${BG_ORANGE}${FG} $(whoami)@$(hostname -s) "
line1+="${BG_YELLOW}${FG_ORANGE}${SEP}"
line1+="${BG_YELLOW}${FG} ${truncated} "
if [ -n "$git_branch" ]; then
    line1+="${BG_AQUA}${FG_YELLOW}${SEP}"
    line1+="${BG_AQUA}${FG} ${git_branch}${git_status_str} "
    line1+="${RESET}${FG_AQUA}${SEP_END}${RESET}"
else
    line1+="${RESET}${FG_YELLOW}${SEP_END}${RESET}"
fi

# Line 2: metrics (model + ctx%, tokens + cost, time)
line2="${FG_BLUE}${SEP_START}"
line2+="${BG_BLUE}${FG} ${model}${ctx_str} "
if [ -n "$usage_str" ]; then
    line2+="${BG_PURPLE}${FG_BLUE}${SEP}"
    line2+="${BG_PURPLE}${FG} ${usage_str} "
    line2+="${BG_BG1}${FG_PURPLE}${SEP}"
else
    line2+="${BG_BG1}${FG_BLUE}${SEP}"
fi
line2+="${BG_BG1}${FG} ${time_str} "
line2+="${RESET}${FG_BG1}${SEP_END}${RESET}"

printf "%b\n%b" "$line1" "$line2"
