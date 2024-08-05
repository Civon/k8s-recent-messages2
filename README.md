# recent-messages2

![Build CI status](https://github.com/robotty/recent-messages2/workflows/Build/badge.svg)

NOTE: Use the project in private endpoint only. If looking for public access, see robotty's site for more privacy regulation's info.

See https://recent-messages.robotty.de/ for all kinds of information you might want.

## Deploy

Using ConfigMap as workaround to store secret in current stage.

1. edit config in configmap.yaml(optional)
2. kaf deployment/

## Features

- [x] containerize to docker image
- [x] deployable k8s file
- [ ] expose using cloudflare tunnel
- [ ] CI/CD pipeline with GitOps
- [ ] optimized docker image
- [ ] contianerize web and monitoring

## Web

Instructions for setting up the static website (like the "official" https://recent-messages.robotty.de/) are found in the [README in the `./web` directory of this repo](./web/README.md).
There you can also find an example nginx config.

## Monitoring

~~A prometheus metrics endpoint is exposed at `/api/v2/metrics`. You can import the `grafana-dashboard.json` in the repository as a dashboard template into a Grafana instance.~~
