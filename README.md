# ngrok-ssh

Spins up a blank ubuntu vm with ngrok and ssh server. Place your ngrok yml config in the config folder that gets mounted. Example ngrok.yml:
```
authtoken: your-ngrok-auth-token
region: us

tunnels:
  ssh:
    proto: tcp
    addr: host.docker.internal:2222
```

To get started:
```
docker run \
  -d \
  --name ngrok-ssh \
  --restart always \
  -p 2222:22 \
  -e TZ=America/New_York \
  -v /Users/<username>/docker/ngrok-ssh/config:/config \
  nickrod518/ngrok-ssh
```
