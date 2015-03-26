# rtmp-balancer

cine.io [Docker](https://docker.com/) container that balances the rtmp-replicator and rtmp-stylist on different rtmp-endpoints.

# Usage

```bash
docker run --name haproxy -d -it -p 80:80 -p 8000:8000 --env CONSUL_URI=192.168.59.103:8500 local/rtmp-balancer
```

# Notes

* You must have [consul](https://github.com/hashicorp/consul) running
  * `docker run --name consul -d -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h LOAD_BALANCER_SERVER progrium/consul -ui-dir /ui -server -advertise 192.168.59.103 -bootstrap`
* You must have [registrator](https://github.com/gliderlabs/registrator) running on each machine you want to register. For this it's probably the same machine
  * `docker run --name registrator -d -v /var/run/docker.sock:/tmp/docker.sock -h $HOSTNAME gliderlabs/registrator consul://192.168.59.103:8500`
* This uses [consul-template](https://github.com/hashicorp/consul-template) to update the haproxy template and reload haproxy
