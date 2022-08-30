# dnsmasqmon

A quick monitoring script using `dig` and some bash to dump the data out of `dnsmasq`'s [CHAOS query stats](https://dnsmasq.org/docs/dnsmasq-man.html).

## Output example

It'll work remotely if you've got DNS allowed remotely, I piped this through `jq` for display purposes.

```shell
./dnsmasqmon.sh anotherhost.example.com | jq . 
{
  "timestamp": "2022-08-30T20:22:25+10:00",
  "cache": "150",
  "evictions": "0",
  "insertions": "3213",
  "hits": "12593",
  "misses": "2249",
  "auth:": "0",
  "servers": [
    "10.0.0.12#53 2249 0",
    "10.0.0.1#53 0 0"
  ]
}
```

This is how it looks without jq:

```json
{"timestamp":"2022-08-30T20:23:27+10:00","cache":"150","evictions":"0","insertions":"3213","hits":"12602","misses":"2249","auth:":"0","servers":["10.0.0.12#53 2249 0","10.0.0.1#53 0 0"]}
```

The "servers" output is a list of upstream servers with the number of queries sent to them... and another number which I don't know what it does. :)