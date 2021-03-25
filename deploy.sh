curl -v -X POST http://20.185.176.246:4243/containers/calculator/kill
curl -v -X DELETE http://20.185.176.246:4243/containers/calculator?force=true
curl -v -X POST http://20.185.176.246:4243/images/prune?dangling=true
sleep 5
curl -v -X POST http://20.185.176.246:4243/images/create?fromImage=pranaycirruslabs/calculator:latest
curl -v -X POST -H "Content-Type: application/json" -d "@docker.json" http://20.185.176.246:4243/containers/create?name=calculator
sleep 5
curl -v -X POST http://20.185.176.246:4243/containers/calculator/start