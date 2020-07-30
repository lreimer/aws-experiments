#cloud-config

package_update: false
package_upgrade: false

final_message: "The Ignite Cluster is finally up, after $UPTIME seconds."

write_files:
  - content: |
        <beans xmlns="http://www.springframework.org/schema/beans"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xmlns:util="http://www.springframework.org/schema/util"
             xsi:schemaLocation="
                http://www.springframework.org/schema/beans
                http://www.springframework.org/schema/beans/spring-beans.xsd
                http://www.springframework.org/schema/util
                http://www.springframework.org/schema/util/spring-util.xsd">
        <bean abstract="true" id="ignite.cfg" class="org.apache.ignite.configuration.IgniteConfiguration">
            <property name="peerClassLoadingEnabled" value="true"/>

            <property name="includeEventTypes">
                <list>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_TASK_STARTED"/>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_TASK_FINISHED"/>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_TASK_FAILED"/>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_TASK_TIMEDOUT"/>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_TASK_SESSION_ATTR_SET"/>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_TASK_REDUCED"/>

                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_CACHE_OBJECT_PUT"/>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_CACHE_OBJECT_READ"/>
                    <util:constant static-field="org.apache.ignite.events.EventType.EVT_CACHE_OBJECT_REMOVED"/>
                </list>
            </property>

            <property name="discoverySpi">
                <bean class="org.apache.ignite.spi.discovery.zk.ZookeeperDiscoverySpi">
                    <property name="zkConnectionString" value="zookeeper-0.zookeeper.cloud,zookeeper-1.zookeeper.cloud,zookeeper-2.zookeeper.cloud"/>
                    <property name="sessionTimeout" value="60000"/>
                    <property name="zkRootPath" value="/ignite"/>
                    <property name="joinTimeout" value="30000"/>
                </bean>
            </property>
        </bean>
        </beans>
    path: /home/ignite/apache-ignite-2.8.1/config/ignite-zookeeper.xml
    owner: ignite:ignite
    permissions: '0644'
