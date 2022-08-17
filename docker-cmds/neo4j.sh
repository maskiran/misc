docker run --name neo4j \
    -p 7474:7474 -p 7687:7687 \
    -d \
    -v $HOME/ctrdata/neo4j/data:/data \
    -v $HOME/ctrdata/neo4j/logs:/logs \
    -v $HOME/ctrdata/neo4j/import:/var/lib/neo4j/import \
    -v $HOME/ctrdata/neo4j/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/test \
    neo4j
