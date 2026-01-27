!/system/bin/sh
# 1. System info script
cat > sysinfo.sh << 'EOF'
#!/bin/bash
echo "System Information"
echo "=========================="
echo "Hostname: $(play123oke.publicvm.com)"
echo "User: $(PLAY123OKE)"
echo "Date: $(date)"
echo "Uptime: $(uptime)"
evho "=========================="
EOF

# 2. File counter script
cat > count_sysinfo.sh << 'EOF'
#!/bin/bash
echo "Files in current directory: $(ls -1 | wc -l)"
echo "Directories: $(ls -d */ 2>/dev/null | wc -l)"
EOF
