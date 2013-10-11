angular.module \ui.choices, <[]>
.directive \choices ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    scope: {model: '=ngModel', id: '='}
    template: "<div class='btn-group' data-toggle='buttons' ng-transclude></div>"

    link: (scope, element, attrs) ->
      scope{type} = attrs
      update = (scope, element) ->
        if scope.type == "array" =>
          scope.model = [$ e .attr \value for e in element.find \label.active]
        else
          if typeof(scope.model) != typeof({}) or ($.isArray scope.model) => scope.model = {}
          v = [[e.className, $ e .attr \value] for e in element.find \label]
          v.filter(-> it.0.search("active")>=0)map(-> scope.{}model[it.1] = true)
          v.filter(-> it.0.search("active")<0)map(-> scope.{}model[it.1] = false)

      update scope, element
      
      element.on \count-active ->
        update scope, element
        scope.$apply!
      scope.$watch \model, (v) ->
        if !v or (!v.length and scope.type=="array") => return
        if scope.type=="array" => v = ["#{x}" for x in v]
        else v = [k for k of v].filter(-> v[it])
        for it in element.find \label
          it = $ it
          if it.attr(\value) in v => it.addClass \active
          else it.removeClass \active
      ,true

    controller: ($scope, $element) ->
      $scope.multiple = $element.attr \multiple
      $scope.btn-type = $element.attr \btn-type
      @is-multiple = -> $scope.multiple
      @btn-type = -> $scope.btn-type

.directive \choice ($compile) ->
  return
    restrict: 'E'
    transclude: true
    replace: true
    require: "^choices"
    template: "<label class='btn'><input type='radio'><span ng-transclude></span></label>"
    link: (scope, element, attrs, ctrl) ->
      element.addClass if ctrl.btn-type! => that else \btn-primary
      if ctrl.is-multiple! => element.find \input .attr \type, \checkbox
      element.on \click -> setTimeout (-> element.parent!trigger \count-active), 0
 
