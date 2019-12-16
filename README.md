# SEC
Simple Event Correlator Docker

**Running Simple event correlator**

`docker-compose up`

or

`docker run --name sec -p 514:514/tcp -p 514:514/udp -d simpleevcorr/sec:latest`

**Using custom rules with docker container**

For providing your own Simple Event Correlator rules you should add a volume mapping to map the external rules folder to /app/rules/ with the .sec suffix, by adding `-v rules:/app/rules` to your docker run command.

**Send test log to SEC**

* View log files

`docker logs -f <container name>`

* Send test log

```echo "Test log message" | nc -4t -w1 127.0.0.1 514
echo '{@cee: {"test":"abc","test2":"blah"}' | nc -4t -w1 127.0.0.1 514```
