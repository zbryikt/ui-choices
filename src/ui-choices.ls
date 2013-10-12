angular.module \ui.choices, <[]>
.directive \toggle ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    template: "<button class='btn' ng-transclude></button>"
    scope: {model: '=ngModel', id: '='}
    link: (s,e,a) ->
      if a[\ngModel] =>
        s.model = a[\active]!=undefined or !!s.model
        e.on \click ->
          e["#{if (s.model = !s.model) => \add else \remove}Class"] \active
          s.$apply!
        s.$watch \model (v) -> e["#{if v => \add else \remove}Class"] \active
          
.directive \choices ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    scope: {model: '=ngModel', id: '='}
    template: "<div class='btn-group' ng-transclude></div>"

    link: (s, e, a) ->
      s.type = a[\type]
      update = (s, e, v) ->
        [d,v] = [s.data, (v and s.data[v]) or {}]
        k = [k for k of d]
        if v.e =>
          if (v.fb or !s.multi) and v.on =>
            k.map -> d[it]on = false
            v.on = true
          else
            (fb = k.filter(->d[it]fb))map -> d[it]on = false
            if !k.filter(->d[it]on)length and fb.length => d[fb.0]on = true
        k.map (i) -> 
          if d[i]m => s.$parent[d[i]m] = d[i]on
          d[i]e["#{if d[i]on => \add else \remove}Class"] \active
        if s.type == "array" => s.model = k.filter(->d[it]on)map -> d[it]v
        else 
          s.model = {}
          k.map -> s.model[it] = !!d[it]on
      update s, e, null
      
      e.on \update (err,t)->
        update s, e, t
        s.$apply!
      s.$watch \model, (d) ->
        if !d or (!d.length and s.type=="array") => return
        if s.type=="array" => d = ["#{x}" for x in d]
        else d = [k for k of d]filter(-> d[it])
        for k,v of s.data
          v.e["#{if v.on = (k in d) => \add else \remove}Class"] \active
          if v.m => s.$parent[v.m] = v.on
      ,true

    controller: ($scope, $element) ->
      $scope.multi = !!($element.attr \multiple)
      $scope.btntype = $element.attr \btn-type
      @node = 
        d: {}
        add: (e,a) ->
          v = a[\value]
          @d[v] = {e, v, m: a[\ngModel], fb: a[\fallback]!=undefined, on: a[\active]!=undefined}
          $scope.$parent.$watch a[\ngModel], (u) ~>
            @d[v]on = u
            setTimeout (~> e.parent!trigger \update, @d[v]v), 0
        tgl: (v) -> @d[v]on = !@d[v]on
      $scope.data = @node.d
      @is-multi = -> $scope.multi
      @btntype = -> $scope.btntype
      @scope = -> $scope

.directive \choice ($compile) ->
  return
    restrict: 'E'
    transclude: true
    replace: true
    require: "^choices"
    scope: {id: '='}
    template: "<label class='btn'><span ng-transclude></span></label>"
    link: (s, e, a, c) ->
      e.addClass if a[\btnType] => that else if c.btntype! => that else \btn-primary
      c.node.add e, a
      e.on \click -> 
        r = c.node.tgl v = e.attr \value
        setTimeout (-> e.parent!trigger \update, v), 0
 
