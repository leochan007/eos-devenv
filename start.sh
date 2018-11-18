#!/bin/bash

docker stop $(docker ps -aq) && docker rm -v $(docker ps -aq)

docker run --name eosio \
  --publish 7777:7777 \
  --publish 127.0.0.1:5555:5555 \
  --volume /Users/leo/Documents/src_codes/eos/contracts:/contracts \
  --detach \
  eosio/eos:v1.4.2 \
  /bin/bash -c \
  "keosd --http-server-address=0.0.0.0:5555 & exec nodeos -e -p eosio \
  --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin \
  --plugin eosio::history_plugin --plugin eosio::history_api_plugin \
  --plugin eosio::http_plugin -d /mnt/dev/data --config-dir /mnt/dev/config \
  --http-server-address=0.0.0.0:7777 --access-control-allow-origin=* \
  --contracts-console --http-validate-host=false --filter-on='*'"

docker run --name eosio_m --publish 127.0.0.1:6666:6666 \
  -v ~/eosio-wallet:/root/eosio-wallet \
  --volume /Users/leo/Documents/src_codes/eos/contracts:/contracts \
  --detach \
  eosio/eos:v1.4.2 \
  /bin/bash -c \
  "keosd --http-server-address=0.0.0.0:6666"

alias mcleos='docker exec -i eosio_m /opt/eosio/bin/cleos --wallet-url http://127.0.0.1:6666 -u https://api.eosnewyork.io:443'

cleos wallet create --to-console

#EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1
cleos wallet import --private-key 5JC34pBkD7JqR37tjc6DA1vDUa8Bdfo5CXHWMprM9BEoDeDnrSw
#EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd
cleos wallet import --private-key 5K3UUSU7aM5nUSg3UR9XoUHfDK53CuSXpwe2q3Y7x9WG4yMLQhj
#EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

cleos wallet unlock --password PW5KfvxhuyDCnsD1jv66VVqA6hfPxHmKqtkruvdpSLsKa6tg8rcAD
cleos wallet private_keys --password PW5KfvxhuyDCnsD1jv66VVqA6hfPxHmKqtkruvdpSLsKa6tg8rcAD

cleos create account eosio alice EOS4ygGanuRgWhuEDRAXUwAZyhKG2TPqN6a3suvXXkjB5Mcr773jd
cleos create account eosio bob EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1
#cleos wallet remove_key EOS6xhekghwi1NmWZ7x9X6XCCFdJAWXnMKMafMUYT2F85Wq1AWarW --password PW5JQEf6yhKy9B44RHKAfowYi7zWcADw38yQWx1oAaJArVJnP2cmS

cleos set account permission bob owner \
'{"threshold":1,"keys":[{"key":"EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1","weight":1}]}' -p bob@owner

cleos set account permission bob newauth \
'{"threshold":2,"keys":[{"key":"EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV","weight":1},
{"key":"EOS8fNtGNYFvjCKjdjCrwmUyU718ZePLG4WrT3fp4R4Pp5gZTVvv1","weight":1}]}' -p bob@owner

cleos set account permission bob newauth NULL

cleos set account permission bob owner EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV -p bob@owner

cleos set account permission bob active NULL -p bob@owner
