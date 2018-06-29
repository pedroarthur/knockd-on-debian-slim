ip route get to "${INTERFACE_DETECT_ADDRESS:=8.8.8.8}" | grep ' dev ' | awk '{print $5}'
