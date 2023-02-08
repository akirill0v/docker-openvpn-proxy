# OpenVPN Proxy
A Privoxy container with OpenVPN  
Built on Alpine Linux so tiny, fast, light and awesome.

... Refactored to use https://github.com/Fuwn/socks_proxy as Socks5 proxy with authentication

## Setup

### Docker

`docker-compose.yml` has been included in the repository for reference.  

### Volume
1 volume needs to be mapped to `/app/ovpn/config` within the container.  
This volume should include any ovpn config files to be used and, credentials.txt.

### VPN Config
I've tested with PIAs ovpn configs but will probably work with any, just make sure to include the following line somewhere:
```
auth-user-pass /app/ovpn/config/credentials.txt
```
or

```
askpass /app/ovpn/config/passphrase.txt
```
for passphrase

I plan to check for / automagically add this line in future.

I left in PIA London config for use if needed.  
Obviously you'll need to have a PIA account.

### Credentials
Create `./credentials.txt` in the directory which is mapped to `/app/ovpn/config`.   
On the 1st line put the username, on the 2nd line the password.

## Environment Variables

### LOCAL_NETWORK
The CIDR mask of the local IP addresses which will be acessing the proxy. This is so the response to a request makes it back to the requestee.

### OPENVPN_FILENAME
The .ovpn file to use. This file should be in the directory which is mapped to `/app/ovpn/config`.

### ONLINECHECK_DELAY
Will make a web request to Google every x seconds (default 900 (15 minutes)). If the request fails, OpenVPN will be restarted.
