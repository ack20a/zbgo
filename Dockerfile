FROM alpine:latest

WORKDIR /app

# Use the correct architecture (Alpine/musl for ARM-based systems, Alpine/glibc for AMD-based systems). This is example for AMD systems.

RUN apk add --no-cache ca-certificates wget \
    && wget https://github.com/layou233/ZBProxy/releases/download/3.0-rc.4/ZBProxy-linux-amd64 -O ZBProxy-linux \
    && chmod +x ZBProxy-linux

# Create a directory for configuration
RUN mkdir -p /etc/zbproxy

# Create the default configuration file - Use proper indentation in the config file.
COPY <<EOF /etc/zbproxy/ZBProxy.json
{
    "Services": [
        {
            "Name": "HypixelDefault",
            "TargetAddress": "mc.hypixel.net",
            "TargetPort": 25565,
            "Listen": 25565,
            "Flow": "auto",
            "IPAccess": {
                "Mode": ""
            },
            "Minecraft": {
                "EnableHostnameRewrite": true,
                "OnlineCount": {
                    "Max": 114514,
                    "Online": -1,
                    "EnableMaxLimit": false
                },
                "NameAccess": {
                    "Mode": ""
                },
                "AnyDestSettings": {},
                "MotdFavicon": "{DEFAULT_MOTD}",
                "MotdDescription": "§d{NAME}§e service is working on §a§o{INFO}§r§c§lProxy for §6§n{HOST}:{PORT}§r"
            },
            "TLSSniffing": {
                "RejectNonTLS": false
            },
            "Outbound": {
                "Type": ""
            }
        }
    ],
    "Lists": {}
}
EOF

CMD [ "./ZBProxy-linux", "-c", "/etc/zbproxy/ZBProxy.json" ]
