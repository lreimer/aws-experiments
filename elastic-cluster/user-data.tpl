#cloud-config

package_update: false
package_upgrade: false

final_message: "The Elasticsearch Node is configured after $UPTIME seconds."

write_files:
  - content: |
        cluster.name: elastic-cluster
        node.name: elasticsearch-${n}
        discovery.seed_providers: ec2
        discovery.ec2.endpoint: ec2.${region}.amazonaws.com
        network.host: _ec2_
        cloud.node.auto_attributes: true
        cluster.initial_master_nodes:
          - elasticsearch-0
    path: /home/ec2-user/elasticsearch-7.9.2/config/elasticsearch.yml
    owner: ec2-user:wheel
    permissions: '0644'
