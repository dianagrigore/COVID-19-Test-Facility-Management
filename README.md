# COVID-19 Testing Facility Management 
## Table of contents
* [Utility](#utility)
* [Conceptual Diagram](#Conceptual)
* [Functionalities](#Functionalities)
* [Technologies](#Technologies)
* [Team](#Team)

## Utility
The Database proides a broad view over the persons tested for COVID-19. When tested, a patient can be declared positive or negative. Positive
tests are added to the testing facility's list, as well as the Public Health District Authority. Contacts can be traced and persons at risk can be
notified. Statistics about symptoms and the rate of infection calculator can help local and national authorities in choosing efficient strategies.
Thus, the application is trying to become an aid in the fight with a difficult and highly complex matter.
	
## Conceptual
https://github.com/dianagrigore/COVID-19-Test-Facility-Management/blob/main/image.jpg?raw=true

## Functionalities
<ol>
<li>
Procedure that generates statistics about simptoms, comorbidities and COVID-19 test result.
<ul>
	<li> List of simptoms that showed up in positive tested individuals </li>
	<li> List of simptoms that showed up in positive testet individuals with comorbidities </li>
	<li> Top 3 most common misleading simptoms </li>
	</ul>
</li>
<li>
 Procedure that traces contact graphs and states whether family or work transmision rate is higher.
</li>
<li>
  Procedure that classifies patients into severity grades.
</li>
<li>
  Procedure that makes a top of cities with the biggest number of positive tests, given a county name.
</li>
<li>
  A set of triggers to allow easy database management.
</li>
<li>
  A package that reads a list of names from an external file and uses a queue to test the people at a given testing facility. At the end of the day,
  a report containing the list of tests is printed.
</li>
</ol>
## Technologies
* SQL
* PL/SQL

## Team
  The app was developed  as a final project in the DBMS at the University of Bucharest, Faculty of Mathematics and Computer Science, 2020-2021.
