wg-dict
===

Generate WireGuard keypairs with publickeys that are matching a specific prefix, identify your peers faster!

```

user@server:~$ wg
interface: wg0
  public key: server1...=
  private key: (hidden)
  listening port: 51820

peer: client1...=
  endpoint: aaa.bbb.ccc.ddd:1234
  latest handshake: 3 seconds ago
  transfer: 2.85 MiB received, 790.37 KiB sent

```

# Usage
 - clone repository, change directory
 - run `chmod +x ./wg-dict.sh`
 - run `./wg-dict.sh xyz` where `xyz` is your desired prefix for the publickey
 - be patient

this might take minutes to hours depending on the length. Recommendation: keep length of prefix <= 3
