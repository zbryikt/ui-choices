ui-choices
==========

angular bound, bootstrap style (multiple) choice button group directive.


Requirements
----------
* AngularJS
* JQuery
* Bootstrap


Usage
----------
download src/ui-choices.js, and include it in your html:

    ...
    <script type="text/javascript" src="path-to-your/ui-choices.js">
    ...

In your angular application, include it as a module:

    angular.module("MyApp", ["ui-choices"]);

You can now use these directives. For example:

    <choices ng-model="my-choices">
      <choice value="bike"> Train
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>

In above example, checked values will be save in "my-choices" as an array. That is, if you choose "Trunk", my-choices will be ["trunk"]. Multiple choices is also possible:

    <choices ng-model="my-choices" multiple="true">
      <choice value="bike"> Train
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>

Then my-choices will be ["bike","trunk"] if Trunk and Car are chosen.

