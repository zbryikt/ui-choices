angular.module \ui.abstract.bar, <[]>
.directive \bar ($compile) ->
  return
    restrict: 'E'
    replace: true
    template: "<div class='progress'><div></div></div>"
    scope: {model: '=ngModel', id: '='}
    link: (s,e,a) ->
      ie = e.children \div .0
      ie.className =  if !e.hasClass \ui => \progress-bar else \bar
      if a[\ngModel] =>
        s.model ?= 0
        s.$watch \model (v) -> ie.style.width = "#{parseInt(v*100)}%"

