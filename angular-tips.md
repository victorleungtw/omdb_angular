Angular

To start
Include script tag for angularJS in head of HTML

From CDN:

    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.17/angular.min.js"></script>
OR

Skeleton/seed app for angularJS app

Just shows how to wire two controllers and views together.

    https://github.com/angular/angular-seed
OR

Yeoman Angular app generator

https://github.com/yeoman/generator-angular
View, Template, Model
The "view" is a projection of the "model" through the html "template"

Whenever the model changes, the view will be updated by Angular through the binding points

Angular expression
A code snippet that is evaluated by Angular with the context of the current model scope instead of the scope of window (global context)

{{ angularExpression }}
Bootstrapping AngularJS apps
There are 3 important things that happen during the app bootstrap:

The injector that will be used for dependency injection is created.

The injector will then create the root scope that will become the context for the model of our application.

Angular will then "compile" the DOM starting at the ngApp root element, processing any directives and bindings found along the way.

Directives
Markers on a DOM element that tell the Angular HTML compiler to attach behavior to that element and/or its children

Adding data *
HTML5 is designed with extensibility for data that should be in the HTML, but not visible. data-* attributes allow us to store extra information on standard, semantic HTML elements without polluting the class name.

https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_data_attributes

ngApp:
Mark which html eleent is the root element of the application
Indicate which portion of the app should be treated as an Angular app

 <html data-ng-app>
ngController:
Attach a controller to a specific place in the DOM

    <div data-ng-controller="ItemListCtrl">
        # code here will have context of ItemListCtrl
    </div>
ngRepeat:
Tells Angular to create a new element for each item in a list

    <ul>
        <li data-ng-repeat="item in items">
            {{item.name}}
        </li>
    </ul>
^ {{item.name}} here denotes a binding, refering to teh application model, set up in the ItemListCtrl controller

To Do
Create an angular app
Add routing, with at least 2 routes
Create files in good directory structure
