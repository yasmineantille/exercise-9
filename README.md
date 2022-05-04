# Exercise 9: Trustworthy Agents

A template for an application implemented with the [JaCaMo 0.9](http://jacamo.sourceforge.net/?page_id=40) framework for programming Multi-Agent Systems (MAS). 

### Project overview
```bash
├── additional-resources
│   ├── org-rules.asl # Provided rules for reasoning to (part of) an organization. Available in https://github.com/moise-lang/moise/blob/master/src/main/resources/asl/org-rules.asl
│   └── org-spec-9.xml # The organization specification for monitoring the temperature in the lab
├── src
│   ├── agt
│   │   ├── inc
│   │   │   ├── skills-extended.asl # Additioanl provided plans
│   │   │   └── skills.asl # Provided plans for reacting to (some) organizational events.
│   │   ├── acting_agent.asl # The acting agent has a plan for manifesting the temperature in the lab by using a robotic arm artifact
│   │   ├── org_agent.asl # The org agent is responsible for initializing and managing a temperature monitoring organization 
│   │   ├── sensing_agent.asl # The sensing agent has a plan for reading the temperature in the lab by using a weather station artifact
│   │   ├── rogue_agent.asl # The sensing agent has a plan for reading the temperature, but it is part of the Rogue team!
│   │   ├── rogue_leader_agent.asl # The sensing agent has a plan for reading the temperature, but it is the leader of the Rogues!
│   │   └── certification_agent.asl # The agent that sends certified references for temperature readers
│   └── env
│       ├── tools
│       │   ├── Converter.java # A converter artifact for rescaling values
│       │   └── HypermediaCrawler.java # A hypermedia crawler artifact for crawling a hypermedia environment starting from an entry point URL
│       │   └── SDBasedEvaluator.java # An artifact for evaluating how many standard deviations values deviate from the mean
│       └── wot
│           └── ThingArtifact.java # A thing artifact for enabling the interaction with a Thing based on a W3C Web of Things Thing Description
├── task.jcm # The configuration file of the JaCaMo application used in Exercise 8
├── task-1-e9.jcm # The configuration file of the JaCaMo application used in Exercise 9 - Task 1
└── task-2-e9.jcm # The configuration file of the JaCaMo application used in Exercise 9 - Task 2
```

### How to run the project
Run with [Gradle 7.4](https://gradle.org/): 
- MacOS and Linux: run the following command
- Windows: replace `./gradlew` with `gradlew.bat`

For ensuring that your implementation of Exercise 8 is compatible with the template:
```shell
./gradlew task
```

For Exercise 9 - Tasks 1-2:
```shell
./gradlew task1e9
```

For Exercise 9 - Task 3-5:
```shell
./gradlew task2e9
```



