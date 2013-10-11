ui-choices
==========

Angular bound, bootstrap style (multiple) choice button group directive. It works on Bootstrap 3.0.


Requirements
----------
* AngularJS
* JQuery
* Bootstrap (3.0+)

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

In above example, checked values will be saved in "my-choices" as an object; for example, if you choose "Trunk", my-choices will be { "trunk": true }. Multiple choices are also possible:

    <choices ng-model="my-choices" multiple="true">
      <choice value="bike"> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>

Then my-choices will be { "bike": true, "car": false, "trunk": true } if Trunk and Bike are chosen.

Options
==========

##### Result as Array

You can configure ui-choices to output array instead of object by adding **data-type="array"** attribute:

    <choices ng-model="my-choices" data-type="array" multiple="true">
      <choice value="bike"> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>

In this case, You will get ["bike","car"] if "Bike" and "Car" are chosen.

##### Button Style

Use **btn-type** to assign custom css class to buttons:

    <choices ng-model="my-choices" btn-type="btn-link">
      <choice value="bike"> Bike
      <choice value="car"> Car
      <choice value="trunk",btn-type="btn-success"> Trunk
    </choices>

##### Default Active Buttons

Choice tag with "active" attribute will be activated by default:

    <choices ng-model="my-choices" btn-type="btn-link">
      <choice value="bike"> Bike
      <choice value="car",active> Car
      <choice value="trunk"> Trunk
    </choices>

##### Exclusive Buttons

Choice tag with "fallback" attribute will be de-activated while other buttons are activated, and be activated when no buttons are activated:

    <choices ng-model="my-choices" btn-type="btn-link">
      <choice value="bike",fallback> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>


Example
----------
You can find a live demo [here](http://zbryikt.github.io/ui-choices/)


License
----------
MIT License
