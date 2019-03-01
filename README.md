# Spring Hello World

This is a very basic Spring Hello World application that serves the value of the application property `message` via the web. While simple it's designed to show off some of the spring-cloud-kubernetes functionality.

## Quick Start

Clone the repo down locally:

```console
git clone https://github.com/paulczar/spring-helloworld.git
cd spring-hello-world
```

Assuming you have Java and Maven installed you can run it with:

```console
$ mvn spring-boot:run
2019-02-27 15:08:41.186  INFO 29802 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2019-02-27 15:08:41.420  INFO 29802 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2019-02-27 15:08:41.426  INFO 29802 --- [           main] net.paulcz.hello.Application             : Started Application in 2.217 seconds (JVM running for 5.332)
2019-02-27 15:08:55.500  INFO 29802 --- [nio-8080-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
2019-02-27 15:08:55.500  INFO 29802 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
2019-02-27 15:08:55.506  INFO 29802 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 5 ms
```

Point your web browser or use wget/curl/httpy at `localhost:8080`:

```console
$ http localhost:8080
HTTP/1.1 200
Content-Length: 17
Content-Type: text/plain;charset=UTF-8
Date: Wed, 27 Feb 2019 21:13:35 GMT

hello development
```

## Build and Run

### With Maven

```console
$ mvn clean install
...
...
[INFO] --- maven-jar-plugin:3.1.1:jar (default-jar) @ hello ---
[INFO] Building jar: /home/user/development/spring/hello/target/hello-0.0.1-BASIC.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 3.238 s
[INFO] Finished at: 2019-02-27T15:15:42-06:00
[INFO] ------------------------------------------------------------------------
```

Then you can run it like so:

> Note: the `MESSAGE` environment variable is not neccesary, but is instead showing that you can change the `message` property to get a different response when accessing the application.

```console
$ MESSAGE="hello world" java -jar target/hello-0.0.1-BASIC.jar

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.3.RELEASE)

2019-02-27 15:16:41.581  INFO 30710 --- [           main] net.paulcz.hello.Application             : Starting Application v0.0.1-SNAPSHOT on paulczar with PID 30710 (/home/pczarkowski/development/spring/hello/target/hello-0.0.1-SNAPSHOT.jar started by pczarkowski in /home/pczarkowski/development/spring/hello)
2019-02-27 15:16:41.584  INFO 30710 --- [           main] net.paulcz.hello.Application             : The following profiles are active: development
2019-02-27 15:16:42.862  INFO 30710 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2019-02-27 15:16:42.893  INFO 30710 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2019-02-27 15:16:42.893  INFO 30710 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.16]
2019-02-27 15:16:42.904  INFO 30710 --- [           main] o.a.catalina.core.AprLifecycleListener   : The APR based Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path: [/usr/java/packages/lib:/usr/lib/x86_64-linux-gnu/jni:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/lib/jni:/lib:/usr/lib]
2019-02-27 15:16:42.974  INFO 30710 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2019-02-27 15:16:42.974  INFO 30710 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1297 ms
2019-02-27 15:16:43.266  INFO 30710 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2019-02-27 15:16:43.556  INFO 30710 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2019-02-27 15:16:43.561  INFO 30710 --- [           main] net.paulcz.hello.Application             : Started Application in 2.546 seconds (JVM running for 2.978)

```

### With Docker

If you have Docker you can skip using Maven and Java and Build a docker image:

```console
$ docker build -t paulczar/spring-hello .
...
...
Step 9/10 : COPY --from=BUILD /src/target/$JAR /app.jar
 ---> 8dc7d3d7bde4
Step 10/10 : ENTRYPOINT ["java","-jar","/app.jar"]
 ---> Running in b96dbe5b88c0
Removing intermediate container b96dbe5b88c0
 ---> 5405805d6f47
Successfully built 5405805d6f47
Successfully tagged paulczar/spring-hello:latest
```

Run it:

```console
$ docker run --name spring-hello -d --rm -p 8080:8080 paulczar/spring-hello
6d47dc1ea4833f1a68c6969d4969a74a4d656b9a85600fd089b3cf0ca9716b9d

$ curl localhost:8080
hello development

$ docker rm -f spring-hello
```
