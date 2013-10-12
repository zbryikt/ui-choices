ui-choices
==========

Angularjs binding for bootstrap-style (multiple) choice button group directive. It follows bootstrap 3.0 button css class naming, so you can directly use bootstrap.css to style your buttons.

'ui-choices' is written in livescript and sass.


Example
----------
A live demo is available [here](http://zbryikt.github.io/ui-choices/).


Requirements
----------
* AngularJS (1.0.8+)
* JQuery (1.10.2+)
* Bootstrap (optional, 3.0+)


Download
----------
You can find the js file [here](https://raw.github.com/zbryikt/ui-choices/master/src/ui-choices.js). 

Optionally you can use [the css file](https://raw.github.com/zbryikt/ui-choices/master/src/ui-choices.css) to style your button instead of using bootstrap. In this case bootstrap won't be a requirement. You can also use [this sass file](https://raw.github.com/zbryikt/ui-choices/master/src/ui-choices.sass) to generate your css file.


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

You can alseo use a single button with "toggle" directive:

    <toggle class="btn-primary" ng-model="my-btn-state"/>

Similarly, you can use "active" to toggle the button by default:

    <toggle class="btn-primary" ng-model="my-btn-state" active/>

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

##### Binding on Specific Button

You can bind data to state of specific button:

    <choices ng-model="my-choices">
      <choice value="bike",ng-model="isBikeChosen"> Bike
      <choice value="car"> Car
      <choice value="trunk"> Trunk
    </choices>


License
----------
MIT License
