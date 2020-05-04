# SEC

Easy to run Simple Event Correlator Docker

Latest version: sec-2.8.3.tar.gz (May 2 2020)

**Running Simple Event Correlator**

`docker-compose up`

or

`docker run --name sec -p 514:514/tcp -p 514:514/udp -d simpleevcorr/sec:latest`

**Using custom rules with docker container**

There are test rules included but for providing your own Simple Event Correlator rules you should add a volume mapping to map the external rules folder to /app/rules/ with the .sec suffix, by adding `-v rules:/app/rules` to your docker run command. Docker will create volume for the rules. Put rules to directory  `/var/lib/docker/rules/_data/`.

**SEC logfile**

Write actions are logged to container standard output. SEC logs are written to `/app/logs/sec.log`. To manage SEC logs then mount directory to host system `-v logs:/app/logs`. Log are in the host machine directory `/var/lib/docker/logs/_data/`

**Send signals to SEC**

First message will start SEC process. After that can send signals to process.
`echo "Initial message" | nc -4t -w1 localhost 514`

* Terminate gracefully

`docker exec simple-evcorr 'sh' '-c' 'kill -TERM $(pgrep -f sec)'`

* Full restart

`docker exec simple-evcorr 'sh' '-c' 'kill -HUP $(pgrep -f sec)'`

* Soft restart

`docker exec simple-evcorr 'sh' '-c' 'kill -USR1 $(pgrep -f sec)'`

* Reopen log file in `/app/logs/sec.log`. Useful for log file rotation

`docker exec simple-evcorr 'sh' '-c' 'kill -USR2 $(pgrep -f sec)'`

* Increase its logging level by one

`docker exec simple-evcorr 'sh' '-c' 'kill -INT $(pgrep -f sec)'`

**Send test log to SEC**

* View log files

`docker logs -f <container name>`

* Send test log

```
echo "Test log message" | nc -4t -w1 127.0.0.1 514
echo '{@cee: {"test":"abc","test2":"blah"}' | nc -4t -w1 127.0.0.1 514
```
