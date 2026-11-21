# SABnzbdVPN for the Mendell Umbrel store

This is a separate community package built around [binhex/arch-sabnzbdvpn](https://github.com/binhex/arch-sabnzbdvpn), with WireGuard/OpenVPN and the Privoxy HTTP proxy. It does not replace the official SABnzbd app and does not alter BookOrbit.

**Unverified on a live Umbrel installation.** The upstream image's current 5.1.3-1-02 tag is used, without a digest pin. Verify image availability/architecture and deployment behavior before installing. The image is designed for Linux; confirm your host architecture is supported.

## Windscribe setup

1. Generate a WireGuard configuration file in your Windscribe account (requires a plan that supports manual WireGuard configurations).
2. Install this community app. It is intentionally configured with `VPN_ENABLED=yes` and should not download outside the VPN; initial startup may fail until the config exists.
3. On the Umbrel host, place your Windscribe file at `<Umbrel app data>/mendell-sabnzbdvpn/data/config/wireguard/wg0.conf`. This is the container's `/config/wireguard/wg0.conf`. Do not commit it.
4. In Umbrel App Settings, set `LAN_NETWORK` to your real LAN CIDR (and account for the Docker bridge ranges you actually need). The default `192.168.1.0/24` is only a placeholder.
5. Restart the app. Inspect the container logs for a connected WireGuard tunnel and verify the public IP from inside the container before using it. Verify the kill switch on a deliberately disconnected tunnel as well.

**Security:** Upstream documents `privileged: true` and the `net.ipv4.conf.all.src_valid_mark=1` sysctl for WireGuard. This gives the container elevated access to the Umbrel host and should be treated as a trust decision. Never commit VPN private keys or Usenet credentials.

## Connections

- SABnzbd UI via the Umbrel tile at port 9916 (Umbrel app proxy forwards to container port 8080).
- Privoxy at `http://<umbrel-host-ip>:8118`. Add an **HTTP** indexer proxy in Prowlarr's Settings → Indexer Proxies and assign it only to the desired indexers with tags.
- SABnzbd uses `/data` mapped to Umbrel's shared storage downloads folder. Set its incomplete/complete folders accordingly, for example `/data/incomplete` and `/data/complete`. Adjust Sonarr/Radarr download-client host, API key, and paths manually; official SABnzbd autoconfiguration does **not** apply to this package.
- Do not run another SABnzbd download client against the same configuration directory. This package uses a distinct app data folder.

The 8118 host port is accessible to other devices on your network unless restricted by your firewall. Privoxy generally has no authentication, so **do not expose 8118 to the Internet**. Restrict inbound access to trusted local clients only; check how the host and Docker firewall handle published ports. For a cross-app connection on Umbrel, the Prowlarr container must be able to reach the Umbrel host address.

### Security and operational limits

Privoxy routes only the requests Prowlarr sends through it; it does not VPN-route the entire Prowlarr container. DNS and traffic outside the configured HTTP proxy should not be assumed private. Test with an indexer and a destination IP checker before relying on it. A default-config Privoxy service and the bundled VPN firewall are not substitutes for deployment tests.

To check logs on Umbrel: use the app's diagnostics interface or `docker logs mendell-sabnzbdvpn_app_1` from the host (container name can vary with Umbrel versions).
