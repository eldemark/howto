#!/bin/bash

# SSH to system B and check the DISPLAY value for the logged-in user
ssh user@system_b << 'EOF'
# Find the graphical session for the user
DISPLAY_VAL=$(who | grep -m 1 -Eo '(:[0-9]+)' || echo "No DISPLAY found")

if [ "$DISPLAY_VAL" == "No DISPLAY found" ]; then
    # Fallback: Check using ps for X or Gnome session (this is useful for RHEL 8)
    DISPLAY_VAL=$(ps -ef | grep -m 1 -Eo ':[0-9]+' | head -n 1)
fi

# Print the detected DISPLAY value (either :0 or :1)
echo "Detected DISPLAY: $DISPLAY_VAL"
EOF
