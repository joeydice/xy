#!/bin/sh

UUID="2c1c0efb-bde9-40c1-a24c-134f0fba8edf"
PORT=80
# config xray
cat << EOF > /etc/config.json
{
  "inbounds":[
    {
      "port": $PORT,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$UUID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    },
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "decryption": "none",
        "clients": [
          {
            "id": "$UUID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    },
    {
      "port": $PORT,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "$UUID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}	
EOF

# run xray
/usr/bin/xray run -config /etc/config.json
