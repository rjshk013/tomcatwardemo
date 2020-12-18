This is a simple demonstration application used in the [Jenkins: The Definitive Guide](http://wakaleo.com/books/jenkins-the-definitive-guide) book.

## Building the project

The project is a simple multi-module Maven project. To build the whole project, just run `mvn install` from the root directory.

## Running the game

The application is a very simple online version of [Conway's 'game of life'](http://en.wikipedia.org/wiki/Conway's_Game_of_Life). To see what the game does, run `mvn install` as described above, then go to the gameoflife-web directory and run `mvn jetty:run`. The application will be running on http://localhost:9090.

## Running the acceptance tests

The acceptance tests are written using Webdriver and [Serenity (previously known as 'Thucydides')](http://thucydides.info). They are designed to run against a running server. Run the jetty instance as described about, then, in another window, go to the gameoflife-acceptance-tests directory and run `mvn clean verify`. The test reports will be generated in the `target/site/thucydides` directory.

Run the project using jenkins
------------------------------
1.build :

1.create a freestyle  job like game-build
2.give repo : 


