# k8s-recent-messages2

Containerize most popular Twitch chat logging service used by popular community-built Twitch IRC apps like Dankchat e.g.

This repo provide a baseline for k8s environment, you may need to adjust some config based on your own cluster setup.  
NOTE: Use the project in private endpoint only. If looking for public access, see robotty's site for more privacy regulation's info.

See https://recent-messages.robotty.de/ for all kinds of information you might want.

## Deploy

Using ConfigMap as workaround to store secret in current stage; Use at your own risk.

1. Edit config in configmap.yaml based on config.toml, twitch access token is a must
2. Apply deployment via `kubectl apply -f deployment/ `

This will deploy a recent-message2 with a postgres DB(stateful, for local test only)

## Deploy Cloudflare tunnel

Additional, you may want to expose your service to outra-net via some services, like [cloudflare i am using here.](https://developers.cloudflare.com/cloudflare-one/tutorials/many-cfd-one-tunnel/)

> Note: We are using k8s secret here, consider using a vault for better security.

1. Create a Cloudflare tunnel by `cloudflared tunnel create <tunnel>`
2. Using `cloudflared tunnel route dns <tunnel> <hostname>` to assign DNS record to the tunnel
3. Reference [file from Cloudflare](https://github.com/cloudflare/argo-tunnel-examples/blob/master/named-tunnel-k8s/cloudflared.yaml) to deploy instances.

## Features


- [x] containerize to docker image
- [x] deployable k8s file
<!-- - [ ] expose using cloudflare tunnel -->
- [ ] CI/CD pipeline with GitOps
- [ ] optimized docker image
- [ ] contianerize web and monitoring

## Web(TBD)

## Monitoring(TBD)
