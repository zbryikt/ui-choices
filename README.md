ui-choices
==========

angular bound, bootstrap style (multiple) choice button group directive.


Requirements
----------
* AngularJS
* JQuery
* Bootstrap

Download
----------
You can find the js file [here](https://raw.github.com/zbryikt/ui-choices/master/src/ui-choices.js).


Usage
----------
download [src/ui-choices.js](https://raw.github.com/zbryikt/ui-choices/master/src/ui-choices.js), and include it in your html:

    ...
    <script type="text/javascript" src="path-to-your/ui-choices.js">
    ...

In your angular application, include it as a module:

    angular.module("MyApp", ["ui.choices"]);

You can now use these directives. For example:

    <choices ng-model="my-choices">
      <choice value="bike"> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>

In above example, checked values will be save in "my-choices" as an object; for example, if you choose "Trunk", my-choices will be { "trunk": true }. Multiple choices is also possible:

    <choices ng-model="my-choices" multiple="true">
      <choice value="bike"> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>

Then my-choices will be { "bike": true, "car": false, "trunk": true } if Trunk and Bike are chosen.

Options
==========

##### Result as Array

You can config ui-choices to output array instead of object by adding **data-type="array"** attribute:

    <choices ng-model="my-choices" data-type="array" multiple="true">
      <choice value="bike"> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>

In this case, You will get ["bike","car"] if "Bike" and "Car" are chosen.

##### Button Style

**btn-type="some-class-name"** will add *some-class-name* css class to buttons. For example:

    <choices ng-model="my-choices" btn-type="btn-link">
      <choice value="bike"> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>


Example
----------
You can find an live demo [here](http://zbryikt.github.io/ui-choices/)


License
----------
MIT License
