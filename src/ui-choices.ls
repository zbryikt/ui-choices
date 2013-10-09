angular.module \ui.choices, <[]>
.directive \choices ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    scope: {multiple: '=', model: '=ngModel', id: '='}
    template: "<div class='btn-group' data-toggle='buttons' ng-transclude></div>"

    link: (scope, element, attrs) ->
      element.on \count-active ->
        scope.model = [$ e .attr \value for e in element.find \label.active]
        scope.$apply!
      scope.$watch \model, (v) ->
        if !v or !v.length => return
        v = ["#{x}" for x in v]
        for it in element.find \label
          it = $ it
          if it.attr(\value) in v =>
            it.addClass \active
          else
            it.removeClass \active
      ,true

    controller: ($scope, $element) ->
      @is-multiple = -> $scope.multiple

.directive \choice ($compile) ->
  return
    restrict: 'E'
    transclude: true
    replace: true
    require: "^choices"
    template: "<label class='btn btn-primary'><input type='radio'><span ng-transclude></span></label>"
    link: (scope, element, attrs, ctrl) ->
      if ctrl.is-multiple! => element.find \input .attr \type, \checkbox
      element.on \click -> setTimeout (-> element.parent!trigger \count-active), 0
 
