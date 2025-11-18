# ssh

This repository acts as a single source-of-truth for all SSH-related things.

## Installation

Add this line to your `/etc/crontab` to automatically update the `authorized_keys` files on the machine every hour:

```
0 * * * * root curl -sL https://github.com/lheidem-edu/ssh/raw/refs/heads/master/update-local.sh | bash
```
