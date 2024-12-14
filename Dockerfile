FROM alpine:latest

WORKDIR /app

# Download the pre-built binary
RUN wget https://github.com/layou233/ZBProxy/releases/download/v3.1-beta.2/ZBProxy-linux-amd64-v1 -O ZBProxy-linux \
    && chmod +x ZBProxy-linux

# Create the default configuration file
COPY <<EOF /app/ZBProxy.json
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
            "Outbound": {
                "Type": ""
            }
        }
    ],
    "Lists": {}
}
EOF

CMD [ "./ZBProxy-linux" ]
